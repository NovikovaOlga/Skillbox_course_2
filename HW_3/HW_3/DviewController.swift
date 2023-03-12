/*
 d) Лейбл и кнопку. В лейбле выводится значение counter (по умолчанию 0), при нажатии counter увеличивается на 1.
 */

import UIKit
import ReactiveKit
import Bond

class DviewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var counter = Property(0) // сигнал о событиях
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plusButton.reactive.tap.with(latestFrom: counter)
            .compactMap { $1 } // ignoreNulls
            .map { $0 + 1 } // преобразуем
            .bind(to: counter) // привяжем
        
        counter
            .map {String($0)}
            .bind(to: counterLabel.reactive.text)
    }
    
}
