/*
 a) Два текстовых поля. Логин и пароль, под ними лейбл и ниже кнопка «Отправить». В лейбл выводится «некорректная почта», если введённая почта некорректна. Если почта корректна, но пароль меньше шести символов, выводится: «Слишком короткий пароль». В противном случае ничего не выводится. Кнопка «Отправить» активна, если введена корректная почта и пароль не менее шести символов.
 */
import Foundation
import UIKit
import ReactiveKit
import Bond

class AviewController: UIViewController {
    
    
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        login.reactive.text
            .ignoreNils()
            .filter {$0.count > 0}
            .map {$0.isValidEmail() ? "" : "некорректная почта"}
            .bind(to: message.reactive.text)
        
        password.reactive.text
            .ignoreNils()
            .filter {$0.count > 0}
            .map {$0.count < 6 ? "Слишком короткий пароль" : ""}
            .bind(to: message.reactive.text)
        
        combineLatest(login.reactive.text, password.reactive.text) {mail, pass in
            return mail?.isValidEmail() ?? true && pass?.count ?? 0 >= 6
        }
        .bind(to: sendButton.reactive.isEnabled)
    }
}

extension String { // https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift#
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
