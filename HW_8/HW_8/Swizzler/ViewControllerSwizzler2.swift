
import UIKit

class ViewControllerSwizzler2: UIViewController {

    var boxItem = ""
    var boxItemImage = ""
    
    @IBOutlet weak var boxItemLabel: UILabel!
    
    @IBOutlet weak var boxImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boxItemLabel.text = "Вы взяли \(boxItem)"
        boxImage.image = UIImage(named: boxItemImage)

    }
    

}
