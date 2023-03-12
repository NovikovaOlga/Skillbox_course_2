// c) одно текстовое поле с вводом числа и кнопкой «Рассчитать». После нажатия на кнопку приложение должно в фоновом режиме найти все простые числа (которые делятся без остатка только на 1 и себя) от единицы до введённого числа. Все найденные числа нужно вывести в консоль вместе с длительностью расчёта этих чисел (длительность — сколько времени ушло на поиск этих чисел);


import UIKit

class ViewControllerC: UIViewController {
    
    var resultBox: [String] = []
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        guard let valueTextField = self.textField.text,
              let valueInt = Int(valueTextField) else { return }
        
        guard valueInt > 0 else { return print ("Недопустимое значение. Введите число больше 0.")}
        
        resultBox = []
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            
            for i in 1...valueInt {
                
                let start = DispatchTime.now().uptimeNanoseconds
                
                let calculateResult = self.calculate(value: i)
                let calcTime = DispatchTime.now().uptimeNanoseconds - start
                if calculateResult {
                    let message = String(format: "для значения \(i) время расчета: \(calcTime)")
                    self.resultBox.append(message)
                }
            }
            DispatchQueue.main.async {
                print("От 1 до \(valueTextField) содержится простых чисел = \(self.resultBox.count). Рассчет: \(self.resultBox)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func calculate(value: Int) -> (Bool) {
        if value <= 1 {
               return false
           }
           if value <= 3 {
               return true
           }
           var i = 2
           while i * i <= value {
               if value % i == 0 {
                   return false
               }
               i = i + 1
           }
           return true
    }
}
    

//
//        guard let valueTextField = self.textField.text,
//              let valueInt = Int(valueTextField) else { return }
//        guard valueInt > 0 else { return print ("Недопустимое значение. Введите число больше 0.")}
//        resultBox = []
//        DispatchQueue.global(qos: .utility).async {  /// можно .background
//
//            let values = 1...valueInt
//
//            for v in values {
//                let start = DispatchTime.now().uptimeNanoseconds
//                let calcTime = DispatchTime.now().uptimeNanoseconds - start
//                if v == 1 || (v % 2 == 0 && v != 2) || (v % 3 == 0 && v != 3) || (v % 5 == 0 && v != 5) || (v % 7 == 0 && v != 7) {
//                } else {
//                    let message = String(format: "для значения \(v) время расчета: \(calcTime)" )
//                    self.resultBox.append(message)
//                }
//            }
//            DispatchQueue.main.async {
//                print("От 1 до \(valueTextField) содержится простых чисел = \(self.resultBox.count). Рассчет: \(self.resultBox)")
//            }
//        }
//    }
//}

//    func calculate(value: Int) -> (Bool) {
//
//        guard value >= 2 else { return false }
//        guard value != 2 else { return true }
//        guard value % 2 != 0 else { return false }
//
//        let result = !stride(from: 3, through: Int(sqrt(Double(value))), by: 2).contains { value % $0 == 0 }
//        return result
//    }
//
//@IBAction func calculateButton(_ sender: UIButton) {
//    guard let valueTextField = self.textField.text,
//          let valueInt = Int(valueTextField) else { return }
//    guard valueInt > 0 else { return print ("Недопустимое значение. Введите число больше 0.")}
//    resultBox = []
//    DispatchQueue.global(qos: .utility).async { [weak self] in /// можно .background
//        guard let self = self else { return }
//        for i in 1...valueInt {
//            let start = DispatchTime.now().uptimeNanoseconds
//            let calculateResult = self.calculate(value: i)
//            let calcTime = DispatchTime.now().uptimeNanoseconds - start
//            if calculateResult {
//                let message = String(format: "для значения \(i) время расчета: \(calcTime)")
//                self.resultBox.append(message)
//            }
//        }
//        DispatchQueue.main.async {
//            print("От 1 до \(valueTextField) содержится простых чисел = \(self.resultBox.count). Рассчет: \(self.resultBox)")
//        }
//    }
//}
//
//func calculate(value: Int) -> (Bool) {
//
//    guard value >= 2 else { return false }
//    guard value != 2 else { return true }
//    guard value % 2 != 0 else { return false }
//
//    let result = !stride(from: 3, through: Int(sqrt(Double(value))), by: 2).contains { value % $0 == 0 }
//    return result
//}
//
