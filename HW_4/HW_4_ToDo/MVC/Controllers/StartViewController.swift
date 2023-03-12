
import UIKit
import CoreData

class StartViewController: UIViewController {
    
    @IBOutlet weak var buttonMVC: UIButton! { didSet {
        buttonMVC.layer.cornerRadius = 45
    }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: false) // уберем footer - чтоб красиво
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated) // вернем footer - чтоб можно было отобразить кнопку back на последующих экранах
      navigationController?.setNavigationBarHidden(false, animated: false)
    }
       
}
