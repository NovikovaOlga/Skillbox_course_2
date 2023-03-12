// MARK: - Visitor

//Посетитель — это поведенческий паттерн проектирования, который позволяет добавлять в программу новые операции, не изменяя классы объектов, над которыми эти операции могут выполняться.

// Пример: выращивание овощей на грядках

// овощи
class Vegetable {
  var name: String // овощ
  var ripe: Bool // созрела
  var quantity: Int // количство

  init(name: String, ripe: Bool, quantity: Int) {
    self.name = name
    self.ripe = ripe
    self.quantity = quantity
  }
}

// грядка
class VegetableBed {
    lazy var vegetables: [Vegetable] = []
    
    func addVegetable(anVegetable: Vegetable) {
        vegetables.append(anVegetable)
    }
    
    func touch(visitor: BasicVisitor) {
        visitor.visit(anObject: self)
        
        for vegetable in vegetables {
            visitor.visit(anObject: vegetable)
        }
    }
}

// протокол визиторов
protocol BasicVisitor {
    func visit(anObject: AnyObject)
}

// визитор: зрелость
class RipeVisitor: BasicVisitor {
    func visit(anObject: AnyObject) {
        
        if let obj = anObject as? Vegetable {
            if obj.ripe {
                print("Грядка: \(obj.name) - созрел")
            } else {
                print("Грядка: \(obj.name) - не созрел")
            }
        }
        
        if let _ = anObject as? VegetableBed {
            print("Степень зрелости овощей: ")
        }
    }
}

// визитор: количество на грядках
class QuantityVisitor: BasicVisitor {
    func visit(anObject: AnyObject) {
        if let obj = anObject as? Vegetable {
            print("Овощ: \(obj.name), шт: \(obj.quantity)")
        }
        
        if let _ = anObject as? VegetableBed {
            print("Количество овощей:")
        }
    }
}

let vegetableBed = VegetableBed()

vegetableBed.addVegetable(anVegetable: Vegetable(name: "Тыквы", ripe: true, quantity: 22))
vegetableBed.addVegetable(anVegetable:  Vegetable(name: "Огурцы", ripe: true, quantity: 58))
vegetableBed.addVegetable(anVegetable:  Vegetable(name: "Баклажаны", ripe: false, quantity: 15))
vegetableBed.addVegetable(anVegetable:  Vegetable(name: "Морковь", ripe: false, quantity: 70))
vegetableBed.addVegetable(anVegetable:  Vegetable(name: "Капуста", ripe: true, quantity: 45))


let quantityVisitor = QuantityVisitor()
let ripeVisitor = RipeVisitor()

print("🥬 🥬 🥬 🥬 🥬 🥬 🥬 🥬 🥬 ")
vegetableBed.touch(visitor: quantityVisitor)
print("🥬 🥬 🥬 🥬 🥬 🥬 🥬 🥬 🥬 ")
vegetableBed.touch(visitor: ripeVisitor)
