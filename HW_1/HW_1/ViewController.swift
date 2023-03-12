import UIKit

/*
 1. Прочитайте главу про протоколы: прочитала
 
 2. Прочитайте главу про расширения: прочитала
 
 3. Прочитайте статью про Protocol Oriented Programming: прочитала
 
 4. Напишите, в чём отличие класса от протокола:
 Класс - это универсальная гибкая конструкция - описание для какого-либо объекта( конструктор).
 Протокол - образец методов, свойств или другие требования, которые соответствуют определенному конкретному заданию или какой-то функциональности, по которым может быть составлен класс (не предоставляет реализацию, только описывает как реализация должна выглядеть).
 
 5. Ответьте, могут ли реализовывать несколько протоколов:
 */
protocol Coffee { // кофе
    var sortCoffee: String { get set }
}

protocol Producers { // производитель
    var producer: String { get set }
}

protocol DeliveryServices { // доставка
    var delivery: String { get set }
}

protocol Stock { // склад (упаковка по весу)
    func packaging(weight: Double) -> Int
}

protocol PackingTime { // маркировка при упаковке
    var marking: Int { get }
}

//--------------------------------------
protocol StepProtocol {
    func stepComp(newpos: CGPoint)
    func stepHuman(newpos: CGPoint)
}

protocol PositionProtocol {
    var position: CGPoint { get set }
}

//--------------------------------------
protocol Flyable {
    func fly()
}

protocol Drawable {
    func draw()
}

class ViewController: UIViewController {
    
    // a) классы (Class),
    
    class CoffeeProducer: Coffee, Producers {
        var sortCoffee: String = "robusta"
        var producer: String = "south africa"
    }
    
    // b) структуры (Struct),
    
    struct ProductionsDeliveryServices: Producers, DeliveryServices {
        var producer: String = "south africa"
        var delivery: String = "avia"
    }
    
    // c) перечисления (Enum),
    
    enum packagingSklad: Stock, PackingTime { //  упакуем и промаркируем
        case Wholesale, Retail // опт и розница
        
        var marking: Int {self.packaging(weight: 100)}
        
        func packaging(weight: Double) -> Int {
            switch self {
            case .Wholesale: // опт
                print("На оптовый склад \(weight / 25)")
                return Int(weight / 25)
            case .Retail: // розница
                print("На розничный склад \(weight / 0.2)")
                return Int(weight / 0.2)
            }
        }
    }
    
    let batch = packagingSklad.Wholesale // опт
    
    // d) кортежи (Tuples).
    
    let dayBatch = ProductionsDeliveryServices(producer: "Nicaragua", delivery: "avia")
    
    /*
     
     6. Создайте протоколы для:
     
     a) Игры в шахматы против компьютера: 1) протокол-делегат с функцией, через которую шахматный движок будет сообщать о ходе компьютера (с какой на какую клетку); 2) протокол для шахматного движка, в который передаётся ход фигуры игрока (с какой на какую клетку); Double-свойство, возвращающее текущую оценку позиции (без возможности изменения этого свойства) и свойство делегата.
     */
    
    class Chess: PositionProtocol {
        var delegate: StepProtocol?
        
        var chessСell: String //= ""
        
        init(chessСell: String) {
            self.chessСell = chessСell
        }
        
        var position: CGPoint {
            get { return .init() }
            set { print(" С \(self.chessСell) на \(newValue)") }
        }
    }
    
    /*
     b) Компьютерной игры: один протокол для всех, кто может летать (Flyable), второй — для тех, кого можно отрисовывать в приложении (Drawable). Напишите класс, который реализует эти два протокола.
     */
    class Dragon: Flyable, Drawable {
        func fly() {
            print("Дракон летит")
        }
        func draw() {
            print("Дракон отрисован")
        }
    }
}

//     7. Создайте расширение с функцией для:

//     a) CGRect, которая возвращает CGPoint с центром этого CGRect’а.

extension CGRect {
    func center() -> CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
let rect = CGRect(x: 0, y: 0, width: 100, height: 180)
let rectCenter = rect.center()

//     b) CGRect, которая возвращает площадь этого CGRect’а.
extension CGRect {
    func square() -> CGFloat {
        width * height
    }
}
let squareRect = rect.square()

//     c) UIView, которое анимированно её скрывает (делает alpha = 0).
extension UIView {
    func alpha0() {
        UIView.animate(withDuration: 2, animations: {
            self.alpha = 0
        })
    }
}
let ufo = UIView()


/*     d) Протокола Comparable, который на вход получает ещё два параметра того же типа: первый  ограничивает минимальное значение, второй —  максимальное, — и возвращает текущее значение, ограниченное этими двумя параметрами. Пример использования:

     7.bound(minValue: 10, maxValue: 21) → 10

     7.bound(minValue: 3, maxValue: 6) → 6

     7.bound(minValue: 3, maxValue: 10) → 7 */


extension Comparable {
    func bound(minValue: Self, maxValue: Self) -> Self {
        if (self < minValue) {
            return minValue //(minValue: 10, maxValue: 21) → 10
    
        } else if (self > maxValue) {
            return maxValue //(minValue: 3, maxValue: 6) -> 6
        }
        return self //(minValue: 3, maxValue: 10) -> 7
    }
}
let result1 = 7.bound(minValue: 10, maxValue: 21)
let result2 = 7.bound(minValue: 3, maxValue: 6)
let result3 = 7.bound(minValue: 3, maxValue: 10)


//     e) Array, который содержит элементы типа Int: функцию для подсчёта суммы всех элементов.

extension Sequence where Element: AdditiveArithmetic { /// https://developer.apple.com/documentation/swift/additivearithmetic
    func sum() -> Element {
        return reduce(.zero, +)
    }
}

let arraySum = [1.1, 2.2, 3.3, 4.4, 5.5].sum()
let rangeSum = (1..<10).sum()

//     8. Напишите, в чём основная идея Protocol Oriented Programming.

// В POP — протокол - абстрактный тип данных (в ООП - класс)
//  в POP ключевую роль играют следующие средства языка: protocol, extensions и constraints.





