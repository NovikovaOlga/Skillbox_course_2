// MARK: - Singleton

// Одиночка - это порождающий паттерн, который гарантирует существование только одного объекта определённого класса, а также позволяет достучаться до этого объекта из любого места программы.

// Пример: проверка статуса игрока (заблокирован: да или нет, если да, то срок до конца блокировки)

final class Singleton {
    private let idPlayer: String
    private let nickName: String
    private let blocking: Bool
    private let endOfBlocking: Int
    
    static let shared = Singleton()
    
    // необходимо скрыть конструктор (сделать приватным)
    private init() {
        self.idPlayer = "f567hc4780gb79"
        self.nickName = "Hobbit2022"
        self.blocking = true
        self.endOfBlocking = 50
    }
    // singleton может содержать в себе некую логику
    internal func blockingStatus() -> Bool {
        let status = (blocking == true) ? true : false
        return status
    }
    
    internal func endOfBlockingStatus() -> Int {
        if blockingStatus() == true {
            return endOfBlocking
        } else {
            return 0
        }
    }
}

class Greeting {
    static func playerGreeting() {
        let idPlayer = Singleton.shared
        let nickName = Singleton.shared
        let blocking = Singleton.shared
        let endOfBlocking = Singleton.shared
        
        
        if idPlayer === nickName ||
            blocking === endOfBlocking ||
            nickName === blocking { // принадлежат одному классу
            
            if blocking.blockingStatus() == false {
                print("Welcome to Middle-earth")
            } else {
                print("Sorry, but the player is blocked for violating the community rules. Until the end of the lock \(endOfBlocking.endOfBlockingStatus()) minutes.")
            }
            
            
        } else {
            fatalError("Access error! Contact customer support.")
            
        }
    }
}

class Authorization {
    func authorizationPlayer() {
        Greeting.playerGreeting()
    }
}

let authorization = Authorization()
authorization.authorizationPlayer()
