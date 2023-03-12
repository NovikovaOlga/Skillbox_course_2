// MARK: - Facade

//Фасад — это структурный паттерн проектирования, который предоставляет простой интерфейс к сложной системе классов, библиотеке или фреймворку.

// Пример: gрименение эффекта к фото

import PlaygroundSupport
import UIKit
import GPUImage

class Facade: UIView {
    
    let imageView = UIImageView()
    let image = UIImage(named: "fotoFruit.jpg")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.frame.size = CGSize(width: frame.width/2, height: frame.height/2)
        
        self.imageView.layer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func fotoColorAbjustmentsSaturationFilter() -> UIImageView {
      
        let picture = GPUImagePicture(image: image)
        
        let fotoPolkaDotFilter = GPUImagePolkaDotFilter()
        fotoPolkaDotFilter.fractionalWidthOfAPixel = 0.01
        picture?.addTarget(fotoPolkaDotFilter)
        fotoPolkaDotFilter.useNextFrameForImageCapture()
        picture?.processImage()
        
        imageView.image = fotoPolkaDotFilter.imageFromCurrentFramebuffer()
        return imageView
    }
}

class Client {
    
    func colorFilerGet(){
        let facade = Facade(frame: UIScreen.main.bounds)
        facade.fotoColorAbjustmentsSaturationFilter()
        PlaygroundPage.current.liveView = facade
    }
}

let client = Client()
client.colorFilerGet()

