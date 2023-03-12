// MARK: - Command

//Команда — это поведенческий паттерн проектирования, который превращает запросы в объекты, позволяя передавать их как аргументы при вызове методов, ставить запросы в очередь, логировать их, а также поддерживать отмену операций.

// Пример: уход за растением: орошение, аэрация, удобрение

import Foundation

protocol Command {
    func irrigation() // начать выполнение
    func aeration() // паузы выполнения
    func fertilizing() // остановить выполнение
 }

// приемник определит методы для выполнения
class Receiver {
    
    func irrigationPlant() { // орошение
        // механика действия
        print ("--Irrigation of the plant.")
    }
    
    func aerationPlant() { // аэрация
        // механика действия
        print ("--Aeration of the plant.")
    }
    
    func fertilizingPlant() { // удобрение
        // механика действия
        print ("--Fertilizing plants.")
    }
}

// ConcreteCommand знает о Receiver и вызывает метод invoker
// реализует методы, в котором вызывается метод из класса Receiver
class ConcreteCommand: Command {
   
    private let receiver: Receiver
    
    init(receiver: Receiver) {
        self.receiver = receiver
    }
  
    func irrigation() {
        receiver.irrigationPlant()
    }
    
    func aeration() {
        receiver.aerationPlant()
    }
    
    func fertilizing() {
        receiver.fertilizingPlant()
    }
}

// Invoker знает, как выполнить команду
// При этом он ничего не знает о конкретной команде, он знает только об интерфейсе
class Invoker {
    
    private var commandsDiary: [Command] = [] // дневник ухода
    
    func setCommand(command: Command) { // добавление команды в дневник
        commandsDiary.append(command)
    }

    func dailyСare() {
        print("Программа ежедневного ухода: полив и рыхление")
        for index in 0..<commandsDiary.count {
            commandsDiary[index].aeration()
            commandsDiary[index].irrigation()
        }
    }
    
    func specialСare() {
        print("Программа специального ухода: внесение удобрений")
        for index in 0..<commandsDiary.count {
            commandsDiary[index].fertilizing()
        }
    }
}

// Client решает, какие команды выполнить и когда, также устанавливает ее получателя с помощью метода SetCommand()
class Client {
    func test() {
        let invoker = Invoker()
        let receiver = Receiver()
        let concreteCommand = ConcreteCommand(receiver: receiver)
        // передает объект команды вызывающему объекту (invoker)
        
        invoker.setCommand(command: concreteCommand)
        invoker.specialСare()
        invoker.dailyСare()
    }
}

let client = Client()
client.test()
