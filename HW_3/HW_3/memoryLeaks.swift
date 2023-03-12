/*
 6. Напишите несколько примеров того, как может образоваться утечка памяти при использовании Rx.
 */
import Foundation

import Foundation
import ReactiveKit
import Bond

class MemoryLeaks: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let h1 = Human()
        let h2 = Human()
        
        // крговая ссылка - утечка памяти (навсегда в оперативнойй памяти).
        // Одно из решений написать weak перед friends
        h1.friend = h2
        h2.friend = h1
    }
  
}

class Human{
    weak var friend: Human? //
    
    init() {
        print("Human+++")
    }
    deinit{
        print("Human---")
    }
}


// Пример 2

class MemoryLeaks2: UIViewController {
   
    var processor:(() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processor = { // ссылается сам на себя и создает утечку памяти
            self.helloWorld()
        }
      }
    
    func helloWorld() {
        print("Hello world!")
    }
}

// Пример 3: когда контроллер 1 ссылается на контроллер 2, контроллер 2 ссылается на контроллер 3 и контроллер 3 ссылается на контроллер 1

/*
 Как избежать утечек памяти:
 1) [weak self] делает ссылку слабой - замыкание не произойдет (self опционален = self?.helloWorld().
 
 // 2) Можно использоать unowned self - в случае когда мы уверены, что self не будет nil
 
 //  3) использовать disposeBag  - хранилище в которое попадают все ссылки

 
 */

