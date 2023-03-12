import UIKit
/*
1. Прочитайте главу про дженерики и ассоциированные типы.

2. Прочитайте главу про операторы.

3. Посмотрите код полной реализации библиотеки анимаций.

4. Напишите, для чего нужны дженерики.
 Дженерики нужны для написания гибких, общего назначения функций и типов.

5. Укажите, чем ассоциированные типы отличаются от дженериков.
Ассоциированный тип определяет дженерик-тип в протоколе, а дженерик - функция или тип общего назначения.
 
6. Создайте функцию, которая:

     a) получает на вход два Equatable-объекта и, в зависимости от того, равны ли они друг другу, выводит разные сообщения в лог;
 */
func checkEquality<T: Equatable>(a: T, b: T) {
    if a == b {
        print("\(a) равно \(b)")
    } else {
        print("\(a) не равно \(b)")
    }
}
checkEquality(a: "Olga", b: "Alex")
checkEquality(a: 7, b: 7)
/*
     b) получает на вход два сравниваемых (Comparable) друг с другом значения, сравнивает их и выводит в лог наибольшее;
*/
func maxValue<T: Comparable>(c: T, d: T) {
    let max = c > d ? c : d
    print("Наибольшее значение: \(max)")
    // можно кратко: print(c > d ? c : d) // вместо верхних двух строк
    // или так: c > d ? print(c) : print(d) // вместо верхних двух строк
}
maxValue(c: 200, d: 280)

/*
     c) получает на вход два сравниваемых (Comparable) друг с другом значения, сравнивает их и перезаписывает первый входной параметр меньшим из двух значений, а второй параметр — большим;
*/
func complianceMinMax<T: Comparable>(_ e: inout T, _ f: inout T) {
    if e > f {
        swap(&e, &f) // Обменивается значениями двух аргументов
    }
    print(e, f) // проверим
}
var eNew = 44
var fNew = 5

complianceMinMax(&eNew, &fNew)
//print(eNew, fNew) // проверим


/*
     d) получает на вход две функции, которые имеют дженерик — входной параметр Т и ничего не возвращают; сама функция должна вернуть новую функцию, которая на вход получает параметр с типом Т и при своём вызове вызывает две функции и передаёт в них полученное значение (по факту объединяет две функции).
*/
func multipleFunc<T>(firstFunc: @escaping(T) -> Void, secondFunc: @escaping(T) -> Void) -> ((T)->()) {
    func result(something: T) {
        firstFunc(something)
        secondFunc(something)
    }
//    let res = result
//    return res
    return result
}

/*
7. Создайте расширение для:

     a) Array, у которого элементы имеют тип Comparable, и добавьте генерируемое свойство, которое возвращает максимальный элемент;
*/
extension Array where Element: Comparable {
    func maxElement() -> Element? {
        guard first != nil else { return nil }
        return self.max()
    }
}
var IntArray = [7, 12, 5, 401, 318]
IntArray.maxElement()

/*
     b) Array, у которого элементы имеют тип Equatable, и добавьте функцию, которая удаляет из массива идентичные элементы.
*/
extension Array where Element: Equatable {
    mutating func removeDouble() { // Cannot assign to value: 'self' is immutable. Mark method 'mutating' to make 'self' mutable.
        var uniqueArray = [Element]()
        for element in self {
            if uniqueArray.contains(element) == false { // можно: if !uniqueArray.contains(element) {
                uniqueArray.append(element)
            }
            self = uniqueArray
        }
    }
}
var checkArray = [7, 4, 5, 11, 7, 11]
print("Массив до проверки: \([checkArray])")
checkArray.removeDouble()
print("Массив после проверки: \([checkArray])")

//8. Создайте специальный оператор для:

//     a) возведения Int-числа в степень: оператор ^^, работает 2^3, возвращает 8;

//postfix operator ^^
//postfix func ^^(number: Int) -> Int {
//    let result =  number * number * number
//    return result
//}
//2^^

infix operator ^^
func ^^(left: Int, right: Int) -> Int {
    var itog = left
    for _ in 1...(right-1) {
        itog *= left
    }
    return itog
}

2^^3
//4^^4 // 256


//     b) копирования во второе Int-числа удвоенного значения первого 4 ~> a, после этого a = 8;

infix operator ~>
func ~> (g: Int, h: inout Int)  {
    h = g * 2
}
var a = 1 //  то есть а может быть любым
4 ~> a

//     c) присваивания в экземпляр tableView делегата: myController <* tableView, поле этого myController становится делегатом для tableView;
infix operator <*
func <*(myController: UIViewController, tableView: UITableView) {
    tableView.delegate = myController as? UITableViewDelegate
}

let vcNew = UIViewController()
let tvNew = UITableView()

vcNew <* tvNew

//     d) суммирует описание двух объектов с типом CustomStringConvertable и возвращает их описание: 7 + “ string” вернет “7 string”.

//struct DiagonalShip { //struct Point {
//    let diagonal: Int //let x: Int, y: Int
//    let nameShip: String
//}
//extension DiagonalShip: CustomStringConvertible {
//    var description: String {
//        return "\(diagonal)" + " \(nameShip)"
//    }
//}
//let diagonalShip = DiagonalShip(diagonal: 7, nameShip: "string")

infix operator +
func +(left: CustomStringConvertible, right: CustomStringConvertible) -> String {
    return left.description + right.description
}
let seven = 7
let stringSeven = " seven"
seven + stringSeven

//9. Напишите для библиотеки анимаций новый аниматор:
protocol Animator {
    associatedtype Target
    associatedtype Value
    
    init(_ value: Value)
    
    func animate(_ target: Target)
}

infix operator -*-
func -*-<T: Animator>(left: T, right: T.Target) {
    left.animate(right)
}

//     a) изменяющий фоновый цвет для UIView;
class BackgroundAnimator: Animator{
    let newValue: UIColor
    required init(_ value: UIColor) {
        newValue = value
    }
    func animate(_ target: UIView) {
        UIView.animate(withDuration: 0.3) { [self] in
            target.backgroundColor = newValue
        }
    }
}

//    b) изменяющий center UIView;

class CenterAnimator: Animator{
    let newValue: (CGFloat, CGFloat)
    required init(_ value: (CGFloat, CGFloat)) {
        newValue = value
    }
    func animate(_ target: UIView) {
        UIView.animate(withDuration: 1.0) { [self] in
            target.center = CGPoint(x: newValue.0, y: newValue.1)
        }
    }
}

//     c) делающий scale-трансформацию для UIView.
class ScaleAnimator: Animator{
    let newValue: CGFloat
    required init(_ value: CGFloat) {
        newValue = value
    }
    func animate(_ target: UIView) {
        UIView.animate(withDuration: 0.5) { [self] in
            target.transform = CGAffineTransform(scaleX: newValue, y: newValue)
        }
    }
}

let newView = UIView()
newView.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
BackgroundAnimator(.cyan) -*- newView
newView.backgroundColor
CenterAnimator((30, 30)) -*- newView
newView.center
ScaleAnimator(2) -*- newView
newView.frame


