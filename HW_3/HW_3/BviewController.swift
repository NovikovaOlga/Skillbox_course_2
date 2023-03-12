/*
 b) Текстовое поле для ввода поисковой строки. Реализуйте симуляцию «отложенного» серверного запроса при вводе текста: если не было внесено никаких изменений в текстовое поле в течение 0,5 секунд, то в консоль должно выводиться: «Отправка запроса для <введенный текст в текстовое поле>».
 */

import UIKit
import ReactiveKit
import Bond

class BviewController: UIViewController {

    @IBOutlet weak var serverRequest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        serverRequest.reactive.text
            .ignoreNils()
            .filter{ $0.count > 0}
            .debounce(for: 0.5)
            .observeNext {text in // Result of call to 'observeNext(with:)' is unused = dispose
                print("Отправка запроса для <\(text)>")
            }
            .dispose(in: reactive.bag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        reactive.bag.dispose()
    }

}
