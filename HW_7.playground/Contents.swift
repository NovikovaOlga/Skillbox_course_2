import Foundation
import UIKit

/*
 1.Прочитайте статью про структуры данных: https://itnan.ru/post.php?c=1&p=468239, https://sodocumentation.net/ru/swift/topic/9116/алгоритмы-с-swift и связанный список: https://habr.com/ru/post/462083/.
 2.Реализуйте класс linked list, работающий только со строками. Сделайте в нём функцию поиска строки.
 3.Реализуйте класс для бинарного дерева поиска, работающий только со строками. Сделайте в нём функцию поиска.
 4.Реализуйте класс для графа со станциями метро, где рёбра хранят в себе длительность переезда между двумя станциями. Сделайте в нём поиск пути (любым способом) с одной станции на другую.
 5.Реализуйте функцию сортировки массива ещё двумя способами, кроме рассказанных на уроке.
 */

// ---------------Задание 2----------------

class LLNode<T> {
    var key: T
    var next: LLNode<T>?
    var previous: LLNode<T>?
    
    init(value: T) {
        key = value
    }
}

class LinkedList<T: Equatable> { // X: Operator function '==' requires that 'T' conform to 'Equatable'
    
    typealias Node = LLNode<T>
    
    var nodeFirst: Node?
    var nodeLast: Node?

    var viewing: String { // выведем для контроля в скобочках через запятую, как Array
        var bracket = "[ "
        guard var node = nodeFirst else {
            return bracket + " ]"
        }
        while let next = node.next {
            bracket += "\(node.key), "
            node = next
        }
        bracket += "\(node.key)"
        return bracket + "]"
    }

    func addNode(_ value: T) { // добавим значение (узел)
        let newNode = Node(value: value)
       
        if let n = nodeLast {
            newNode.previous = n
            n.next = newNode
        } else {
            nodeFirst = newNode
        }
        nodeLast = newNode
    }
    
    func search(_ query: T?) -> Bool {
        var nodeBox = nodeFirst
        while nodeBox != nil {
            if nodeBox?.key == query {
                return true
            }
            nodeBox = nodeBox?.next
        }
        return false
    }
}

var playersList = LinkedList<String>()

playersList.addNode("001")
playersList.viewing
playersList.addNode("456")
playersList.viewing
playersList.addNode("218")
playersList.addNode("067")
playersList.addNode("101")
playersList.viewing

playersList.search("001")
playersList.search("101")
playersList.viewing
playersList.search("333")
playersList.viewing
playersList.search("218")


// ---------------Задание 3----------------

//3.Реализуйте класс для бинарного дерева поиска, работающий только со строками. Сделайте в нём функцию поиска.

class Node<T> {  // узел дерева
    
    var head: T
    var left: Node?
    var right: Node?
    
    init(value: T, leftNode: Node? = nil, rightNode: Node? = nil) {
        self.head = value
        self.left = leftNode
        self.right = rightNode
    }
}

// класс работает только со строками, на самом деле нет
class BST<T: Comparable & CustomStringConvertible> { // BST - класс (в нем расстановка узлов и функция поиска)
    
    var head: Node<T>? //root node - корневой узел
    
    func node(_ value: T) {  // сам узел
        let node = Node(value: value)
        if let head = head {
            addNode(head, node)
        } else {
            head = node
        }
    }
    
    func addNode(_ value: Node<T>, _ node: Node<T>) { // расстановка узлов
        if value.head > node.head {
            if let leftNode = value.left {
                addNode(leftNode, node)
            } else {
                value.left = node
            }
        } else {
            if let rightNode = value.right {
                self.addNode(rightNode, node)
            } else {
                value.right = node
            }
        }
    }
    
    func printTree() { // посмотреть на дерево
        self.inorder(self.head)
    }
    
    private func inorder(_ node: Node<T>?) {
        guard let _ = node else { return }
        self.inorder(node?.left)
        print("\(node!.head)", terminator: " ")
        self.inorder(node?.right)
    }
    
    func search(_ value: T) {
        search(head, value)
    }
    
    private func search(_ head: Node<T>?, _ element: T) {
        
        guard let root = head else {
            print("Значение *\(element)* не найдено.")
            return
        }
        
        if element > root.head {
            search(root.right, element)
        } else if element < root.head {
            search(root.left, element)
        } else {
            print("Значение *\(root.head)* найдено.")
        }
    }
}

/*
                                        "свет"
                                      /        \
                               "кальмар"      "печенье"
                              /        \              \
                        "веревка"     "мост"          "ужин"
                                                        \
                                                        "шарики"
 */

var gameTree = BST<String>()
gameTree.node("свет")
gameTree.node("кальмар")
gameTree.node("печенье")
gameTree.node("веревка")
gameTree.node("мост")
gameTree.node("ужин")
gameTree.node("шарики")

gameTree.printTree()

gameTree.search("свет")
gameTree.search("тьма")
gameTree.search("печенье")


// ---------------Задание 4----------------

/* 4.Реализуйте класс для графа со станциями метро, где рёбра хранят в себе длительность переезда между двумя станциями. Сделайте в нём поиск пути (любым способом) с одной станции на другую. */

class Node1 {
    var visited = false
    var connections: [Connection] = []
}

class Connection {
    public let to: Node1
    public let weight: Int
    
    public init(to node: Node1, weight: Int) {
        self.to = node
        self.weight = weight
    }
}

class Path {
    public let cumulativeWeight: Int
    public let node: Node1
    public let previousPath: Path?
    
    init(to node: Node1, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if let previousPath = path,
           let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }
}

extension Path {
    var array: [Node1] {
        var array: [Node1] = [self.node]

        var iterativePath = self
        while let path = iterativePath.previousPath {
            array.append(path.node)
            iterativePath = path
        }
        return array
    }
}

func shortestPath(source: Node1, destination: Node1) -> Path? {
    var frontier: [Path] = [] {
        didSet { frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } }
    }
    
    frontier.append(Path(to: source))
    
    while !frontier.isEmpty {
        let cheapestPathInFrontier = frontier.removeFirst() // путь
        guard !cheapestPathInFrontier.node.visited else { continue }
        
        if cheapestPathInFrontier.node === destination { // проверка на идентичность
            return cheapestPathInFrontier // быстрый путь
        }
        
        cheapestPathInFrontier.node.visited = true
        
        for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // добавим новый путь
            frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
        }
    }
    return nil // пути нет
}

class MyNode: Node1 {
    let name: String
    
    init(name: String) {
        self.name = name
        super.init()
    }
}

let nodeA = MyNode(name: "A")
let nodeB = MyNode(name: "B")
let nodeC = MyNode(name: "C")
let nodeD = MyNode(name: "D")
let nodeE = MyNode(name: "E")

nodeA.connections.append(Connection(to: nodeB, weight: 11))
nodeB.connections.append(Connection(to: nodeC, weight: 19))
nodeC.connections.append(Connection(to: nodeD, weight: 7))
nodeB.connections.append(Connection(to: nodeE, weight: 8))
nodeE.connections.append(Connection(to: nodeC, weight: 9))

let sourceNode = nodeA
let destinationNode = nodeC

var path = shortestPath(source: sourceNode, destination: destinationNode)
var time = path?.cumulativeWeight ?? 0

if let succession: [String] = path?.array.reversed().compactMap({ $0 as? MyNode}).map({$0.name}) {
    print("Лучший путь \(succession) за \(time) мин. ")
}

// ---------------Задание 5----------------
//5.Реализуйте функцию сортировки массива ещё двумя способами, кроме рассказанных на уроке.

// Шейкерная сортировка
func shakerSorting(list: inout [Int], max: Int) {
    var count = Array<Bool>(repeating: false, count: max + 1)
    
    for i in list { count[i] = true }

    var index = 0
    for i in count.indices {
        if count[i] {
            list[index] = i
            index += 1
        }
    }
}
var shaker = [28,11,19,5,24,15]
shakerSorting(list: &shaker, max: shaker.max()!)

// Быстрая сортировка
func quickSort<T:Comparable>(_ list: [T]) -> [T] {

    if list.count > 1 {
        let pivot = list[0+(list.count - 0)/2] //опорный элемент - середина массива
        var less:[T] = [] // меньшe, чем опорный
        var equal:[T] = [] // равны
        var greater:[T] = [] // больше

        for element in list {
            if element < pivot {
                less.append(element)
            } else if element == pivot {
                equal.append(element)
            } else if element > pivot {
                greater.append(element)
            }
        }
        return quickSort(less) + equal + quickSort(greater)
    } else {
        return list
    }
}

var quick = [28,11,19,5,24,15]
quickSort(quick)

/* Анализ времени выполнения алгоритма быстрой сортировки
Время выполнения алгоритма быстрой сортировки зависит от того, какой элемент выбран в качестве опорного (pivot) т.е. от степени сбалансированности. Если разбиение сбалансированное, то алгоритм работает так же быстро, как и сортировка слиянием, в противном случае время выполнения алгоритма такое же как и у алгоритма сортировки вставкой.
Наихудшее разбиение
Наихудшее разбиение имеет место быть, когда процедура разбиения возвращает два подмассива: один длиной 0 элементов, второй n-1. Таким образом, если на каждом уровне рекурсии разбиение максимально несбалансированное, то время выполнения алгоритма быстрой сортировки равно Thetta(n^2).
 Наилучшее разбиение
 В самом благоприятном случае процедура разбиения массива делит задачу на две подзадачи, размер каждой из которых не превышает n/2.

*/

func quickSortR<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { return a }

  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot }
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }

  return quickSortR(less) + equal + quickSortR(greater)
}

var quickR = [28,11,19,5,24,15]
quickSortR(quickR)

