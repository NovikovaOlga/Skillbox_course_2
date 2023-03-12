// MARK: - Virtual Proxy

//Заместитель — это структурный паттерн проектирования, который позволяет подставлять вместо реальных объектов специальные объекты-заменители. Эти объекты перехватывают вызовы к оригинальному объекту, позволяя сделать что-то до или после передачи вызова оригиналу.

// Пример: контроль доступа к игровому серверу

class User {
    let id = "rt56ywl783"
}

protocol ServerProtocol {
    func allowAccess(user: User)
    func denyAccess(user: User)
}

class ServerSide: ServerProtocol {
    func allowAccess(user: User) {
        print("Access allowed to user witch id = \(user.id)")
    }
    
    func denyAccess(user: User) {
        print("Access denied to user witch id = \(user.id)")
    }
}

class ServerProxy: ServerProtocol {
    
    lazy private var server: ServerSide = ServerSide()
    
    func allowAccess(user: User) {
        server.allowAccess(user: user)
    }
    
    func denyAccess(user: User) {
        server.denyAccess(user: user)
    }
}

let user = User()
let proxy = ServerProxy()

proxy.denyAccess(user: user)
print("Try again later.")
proxy.allowAccess(user: user)






