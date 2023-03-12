/*
 e) Две кнопки и лейбл. Когда на каждую кнопку нажали хотя бы один раз, в лейбл выводится: «Ракета запущена».
 */

import UIKit
import ReactiveKit
import Bond

class EviewController: UIViewController {
    
    var status = Property((false, false))
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var messageRocket: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        oneButton.reactive.tap.observeNext { self.status.value.0 = true }
            .dispose(in: reactive.bag)
        
        twoButton.reactive.tap.observeNext { self.status.value.1 = true }
            .dispose(in: reactive.bag)
        
        status.filter { $0.0 == true && $0.1 == true}
            .replaceElements(with: "Ракета запущена")
            .bind(to: messageRocket.reactive.text)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reactive.bag.dispose()
    }
}
