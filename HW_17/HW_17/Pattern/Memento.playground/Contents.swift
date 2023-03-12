// MARK: - Memento

// Снимок — это поведенческий паттерн проектирования, который позволяет сохранять и восстанавливать прошлые состояния объектов, не раскрывая подробностей их реализации.

// Пример: отмена действий игрока (возврат к последнему сохранению)

protocol Action {
    var playerActions: [PlayerAction] { get }
}

struct PlayerAction {
    let x: String
}

// Создатель
class Originator {
   
    private var plAc: [PlayerAction] = []
    
    var description: String {
        plAc.reduce("Player Action: ", { "\($0)[\($1.x)]" })
    }
    
    func move(pos: [PlayerAction]) {
        plAc.append(contentsOf: pos) // присоединяем новую последовательность шагов к массиву
        print(self.description) // вывод в лог
    }
    
    func saveState() -> Action {
        Memento(points: plAc)
    }
    
    func restore(action: Action) {
        plAc = action.playerActions
    }
}

// Хранитель
class Memento: Action {
    
    internal var playerActions: [PlayerAction] = []
    
    init(points: [PlayerAction]) {
        self.playerActions = points
    }
}

// Опекун
class Caretaker {
    private var action: [Action] = []
    private var curIndex: Int = 0
    private let originator: Originator
    
    init(originator: Originator) {
        self.originator = originator
    }
    
    internal func save() {
        // проверяем где на данный момент находится текущий индекс
        let endIndex = action.count - 1 - curIndex
        if endIndex > 0 { action.removeLast(endIndex) }
        
        action.append(originator.saveState())
        curIndex = action.count - 1
        print("Save action: \(originator.description)")
    }
    // возвращаемся на указаную позицию
    internal func back(at state: Int) {
        guard state <= curIndex else { return }
        
        curIndex -= state
        originator.restore(action: action[curIndex])
        print("Return to \(state) pos: \(originator.description)")
    }
    // восстанавливаем указаную позицию
    internal func restore(state: Int) {
        let newIndex = curIndex + state
        
        curIndex = newIndex
        originator.restore(action: action[curIndex])
        print("Restore pos: \(state)! >>> \(originator.description)")
    }
}

let originator = Originator()
let caretaker = Caretaker(originator: originator)

originator.move(pos: [PlayerAction(x:"stands on a mountain")])
caretaker.save()

originator.move(pos: [PlayerAction(x:"take a step")])
caretaker.save()

originator.move(pos: [PlayerAction(x:"take a step")])
caretaker.save()

originator.move(pos: [PlayerAction(x: "fell from the mountain")])
caretaker.save()

caretaker.back(at: 3)
