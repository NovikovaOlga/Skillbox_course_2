
import UIKit
//7. Сделайте модель с функцией валидации логина (почты) и пароля: логин должен быть корректной почтой, пароль — не менее шести символов, которые содержат как минимум одну цифру, одну букву в нижнем регистре и одну — в верхнем. При ошибке модель должна возвращать ошибку (если есть) или успех. Сделайте экран для ввода логина и пароля, где кнопка «Войти» становится активной, если поле логина и поле пароля не пустые. При нажатии на кнопку в случае ошибки должна показываться надпись с текстом ошибки, в случае успеха — экран с поздравлением. 

class ViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPasswordChanged(_ sender: UITextField) { // привязан к 2 текстфилдам
        illuminationButton()
    }
    
    @IBOutlet weak var press: UIButton!
    
    @IBAction func pressButton(_ sender: Any) {
        //        // способ 2 - без сеги в сториборде (удалить сегу)
        //        guard let login = loginTextField.text else { return }
        //        guard let password = passwordTextField.text else { return }
        //
        //        if validateEmail(candidate: login) {
        //            messageLabel.text = "успешный успех"
        //            if password.count > 0 {
        //                if validatePassword(candidate: password) {
        //                    messageLabel.text = "успешный успех"
        //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                    let congratulationVC = storyboard.instantiateViewController(identifier: "congratulationViewController")
        //                    show(congratulationVC, sender: self)
        //                } else {
        //                    messageLabel.text = "ароль — не менее шести символов, которые содержат как минимум одну цифру, одну букву в нижнем регистре и одну — в верхнем"
        //                }
        //            } else if password.isEmpty {
        //                messageLabel.text = "ошибка пароля"
        //            } else {
        //                messageLabel.text?.removeAll()
        //            }
        //        } else if validateEmail(candidate: login) && validatePassword(candidate: password) {
        //            messageLabel.text?.removeAll()
        //        } else {
        //            messageLabel.text = "ошибка почты"
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        press.isEnabled = false
        messageLabel.alpha = 0
    }
    
    func illuminationButton() { // подсветка кнопки
        
        messageLabel.text = ""
        
        if loginTextField.text != nil && loginTextField.text != "" && passwordTextField.text != nil && passwordTextField.text != "" {
            if messageLabel.alpha == 1 { messageLabel.alpha = 0 }
            press.isEnabled = true
        } else {
            if messageLabel.alpha == 1 { messageLabel.alpha = 0 }
            press.isEnabled = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {  // сега к поздравлениям
        let identification = identificationUser()
        return identification
    }
    
    func identificationUser() -> Bool {
        
        guard let login = loginTextField.text, let password = passwordTextField.text else { return false }
        
        if validateEmail(candidate: login) {
            messageLabel.text = "успешный успех"
            if password.count > 0 {
                if validatePassword(candidate: password) {
                    if messageLabel.alpha == 0 { messageLabel.alpha = 1 }
                    messageLabel.text = "успешный успех"
                    return true
                } else {
                    if messageLabel.alpha == 0 { messageLabel.alpha = 1 }
                    messageLabel.text = "пароль — не менее шести символов, которые содержат как минимум одну цифру, одну букву в нижнем регистре и одну — в верхнем"
                    return false
                }
            } else if password.isEmpty {
                if messageLabel.alpha == 0 { messageLabel.alpha = 1 }
                messageLabel.text = "ошибка пароля"
                return false
            } else {
                messageLabel.text?.removeAll()
                return true
            }
        } else if validateEmail(candidate: login) && validatePassword(candidate: password) {
            messageLabel.text?.removeAll()
            return true
        } else {
            if messageLabel.alpha == 0 { messageLabel.alpha = 1 }
            messageLabel.text = "ошибка почты"
            return false
        }
    }
}

extension ViewController { // проверка логина и пароля https://emailregex.com/
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func validatePassword(candidate: String) -> Bool {
        let passRegex = "^(?=.*?[0-9])(?=.*?[a-z])(?=.*?[A-Z]).{6,}$"
        /* пароль — не менее шести символов, которые содержат как минимум одну цифру, одну букву в нижнем регистре и одну — в верхнем
         "" - все в кавычках, ^ - начало, $ - конец
         (?=.*?[0-9]) - как минимум одну цифру
         (?=.*?[a-z]) - одну букву в нижнем регистре
         (?=.*?[A-Z]) - и одну — в верхнем
         .{6,} - пароль — не менее шести символов
         */
        return NSPredicate(format: "SELF MATCHES %@", passRegex).evaluate(with: candidate)
    }
}

