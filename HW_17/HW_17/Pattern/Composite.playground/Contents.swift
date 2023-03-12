// MARK: - Composite

//Компоновщик — это структурный паттерн проектирования, который позволяет сгруппировать множество объектов в древовидную структуру, а затем работать с ней так, как будто это единичный объект.

// Пример: древовидная структура Ордена Древних (культисты в Ассасин Одиссея)

protocol Orden { // коллеги ордена
    func hire(orden: Orden) // нанимает
    func getInfo()
    var lvl: Int { get }
    var name: String { get }
}

// branch
class Сultist: Orden {
    
    private var ordens = [Orden]()
    var lvl: Int
    var name: String
    
    init(lvl: Int, name: String) {
        self.lvl = lvl
        self.name = name
    }
    
    func hire(orden: Orden) {
        self.ordens.append(orden)
    }
    
    func getInfo() {
        print(self.lvl.description + " level Cultist: " + self.name.description )
        for orden in ordens {
            orden.getInfo()
        }
    }
}

// leaf
class LowLvlСultist: Orden {
    
    var lvl: Int
    var name: String
    
    init(lvl: Int, name: String) {
        self.lvl = lvl
        self.name = name
    }
    
    func hire(orden: Orden) {
        print("can't hire")
    }
    
    func getInfo() {
        print(self.lvl.description + " level Cultist: " + self.name.description )
    }
}

let cultist_1 = Сultist(lvl: 1, name: "Пактий Охотник")
let cultist_2_1 = Сultist(lvl: 2, name: "Аканфа Обманщица")
let cultist_2_2 = Сultist(lvl: 2, name: "Эхион Наблюдатель")
let cultist_3_1 = Сultist(lvl: 3, name: "Бубар Заговорщик")
let cultist_3_2 = Сultist(lvl: 3, name: "Конон Боец")
let cultist_4_1 = Сultist(lvl: 4, name: "Тимоса Целительница")
let cultist_4_2 = Сultist(lvl: 4, name: "Фратагуна Хранительница")

cultist_1.hire(orden: cultist_2_1)
cultist_1.hire(orden: cultist_2_2)
cultist_2_1.hire(orden: cultist_3_1)
cultist_2_2.hire(orden: cultist_3_2)
cultist_3_1.hire(orden: cultist_4_1)
cultist_3_2.hire(orden: cultist_4_2)

cultist_1.getInfo()
