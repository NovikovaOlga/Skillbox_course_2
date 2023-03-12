/*
 напишите код, который с помощью swizzling’а добавляет в стандартный класс UIImagePickerController возможность сразу получить выбранную фотографию из галереи;
 */

import UIKit

class ViewControllerPicker: UIViewController {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func button(_ sender: Any) {
        self.picker.swizzling(vc: self, callback: { [weak self] output in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = output
            }
        })
    }
}

class PickedImage {  /// примем и отдадим значение
    var value: ((UIImage?) -> ())?
    init(_ value: @escaping (UIImage?) -> ()) { /// @escaping удержит значение в памяти до того момента, когда это значение будет необходимо получить
        self.value = value
    }
}

extension UIImagePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self /// UIImagePickerController - делегат
    }
    
    struct AssociatedKey {
        static var ImagePickedKey = "ImagePickedKey"
    }
    
    typealias ImagePicked = (UIImage?) -> (Void)
    var configurateImagePicked: ImagePicked? {
        get {
            let img = objc_getAssociatedObject(  /// получение значения у PickedImage для объекта по ключу
                self,
                &AssociatedKey.ImagePickedKey
            ) as? PickedImage
            return img?.value
        }
        set {
            objc_setAssociatedObject(
                self, /// объект для которого создается связь
                &AssociatedKey.ImagePickedKey,
                PickedImage(newValue!), /// значение, которое будет связано с объектом
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func swizzling(vc: UIViewController, callback: ImagePicked?) {
        UIImagePickerController.swizzlingPicker.toggle()
        self.configurateImagePicked = callback
        vc.present(self, animated: true, completion: nil)
    }
    
    fileprivate static var swizzlingPicker: Bool = {
        let originalSelector = #selector(UIImagePickerController.imagePickerController(_:didFinishPickingMediaWithInfo:)) /// выполним функцию и проверим существование метода
        let swizzledSelector = #selector(UIImagePickerController.extImagePickerController(_:didFinishPickingMediaWithInfo:))
        let instanceClass = UIImagePickerController.self /// класс в котором будут заменены методы
        let originalMethod = class_getInstanceMethod(instanceClass, originalSelector)  /// описание и вызов методов
        let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector)
        
        let didAddMethod =
            class_addMethod(instanceClass, originalSelector,
                            method_getImplementation(swizzledMethod!),
                            method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(instanceClass, swizzledSelector,
                                method_getImplementation(originalMethod!),
                                method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        return true
    }()
    
    @objc public func extImagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[.originalImage] as? UIImage /// прием данных
        self.configurateImagePicked?(originalImage) /// присвоение картинки
        
        self.dismiss(animated: true, completion: {
            print("extImagePickerController: dismiss")
        })
    }
    
    @objc public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: {
            print("imagePickerController: dismiss")
        })
    }
}

