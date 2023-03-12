// d) создайте класс, который последовательно выполняет полученные задачи в фоновом режиме: в него можно добавить задачу (на ваш выбор — либо класс с функцией run(), либо блок () → Void). При добавлении задачи класс проверяет, выполняется ли сейчас другая задача. Если да, он добавляет эту задачу в очередь, если нет — сразу начинает выполнять задачу в фоновом потоке. После выполнения задачи класс проверяет, есть ли другие задачи в очереди. Если есть, то берёт ту, которая была добавлена раньше других, приступает к ней и удаляет её из очереди.
import UIKit

protocol beholderRun: class {
    func run(iMin: Int, iMax: Int)
}

class bookkeeper: beholderRun {
    var resultBox = [String]()
    func run(iMin: Int, iMax: Int) {
        for i in iMin...iMax {
         //   let start = DispatchTime.now().uptimeNanoseconds
            let calculateResult = self.calculate(value: i)
         //   let calcTime = DispatchTime.now().uptimeNanoseconds - start
            if calculateResult {
                let message = String(format: "\(i)_")
                self.resultBox.append(message)
            }
        }
        print("🗂", "простых чисел = \(self.resultBox.count)")
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

class ViewControllerD: UIViewController {
    
    let queueStepByStep = OperationQueue()
    
    let bookkeeper1 = bookkeeper()
    let bookkeeper2 = bookkeeper()
    let bookkeeper3 = bookkeeper()
    
    @IBAction func runButtonWork(_ sender: Any) {
        queueStepByStep.addOperation {
            print("IN: бухгалтер работает")
            self.bookkeeper1.run(iMin: 1, iMax: 30)
            sleep(1)
            print("OUT: бухгалтер работает")
            print("-----------------------------------")
        }
    }
    
    @IBAction func buttonDinner(_ sender: Any) {
        queueStepByStep.addOperation {
            print("IN: бухгалтер обедает ")
            self.dinner()
            sleep(2)
            print("OUT: бухгалтер обедает ")
            print("-----------------------------------")
        }
    }
    
    @IBAction func runSomeWork(_ sender: Any) {
        queueStepByStep.addOperation {
            print("IN: бухгалтер немного работает ")
            self.bookkeeper2.run(iMin: 50, iMax: 200)
            sleep(1)
            print("OUT: бухгалтер немного работает ")
            print("-----------------------------------")
        }
    }
    
    @IBAction func runMuchWork(_ sender: Any) {
        queueStepByStep.addOperation {
            print("IN: бухгалтер работает сверхнормы")
            self.bookkeeper3.run(iMin: 100, iMax: 600)
            sleep(2)
            print("OUT: бухгалтер работает сверхнормы")
            print("-----------------------------------")
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        queueStepByStep.addOperation {
            print("IN: бухгалтер едет домой")
            self.goHome()
            sleep(1)
            print("OUT: бухгалтер едет домой")
            print("-----------------------------------")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        queueStepByStep.maxConcurrentOperationCount = 1
    }
    
    func dinner() {
        print ("🥑", "🥐", "🍗", "🍲", "🧁")
    }
    
    func goHome() {
        print ("🌚", "🚗", "🗿")
    }
    
}

