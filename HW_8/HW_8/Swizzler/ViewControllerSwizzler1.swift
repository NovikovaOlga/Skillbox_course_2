/*
 добавьте в проект SegueSwizzler: https://drive.google.com/open?id=1xqRpsiNbUTsVFsJYsQUfXMvPwFqfZeTx, сделайте несколько переходов на другие экраны с передачей данных на них с помощью нового performSegue;
 */
import UIKit

class ViewControllerSwizzler1: UIViewController {
    
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var glovesButton: UIButton!
    @IBOutlet weak var qrcodeButton: UIButton!
    
    @IBAction func maskButtonPressed(_ sender: UIButton) {
        performSegueWithIdentifier(identifier: "ViewControllerSwizzler2", sender: sender) { segue in
            let vc = segue.destination as? ViewControllerSwizzler2
            vc?.boxItem = "маску"
            vc?.boxItemImage = "mask_coronavirus_measures_icon_133615"
        }
    }
    
    @IBAction func glovesButonPressed(_ sender: UIButton) {
        performSegueWithIdentifier(identifier: "ViewControllerSwizzler2", sender: sender) { segue in
            let vc = segue.destination as? ViewControllerSwizzler2
            vc?.boxItem = "перчатки"
            vc?.boxItemImage = "Gloves_Cleaning_Medical_Surgical_icon-icons.com_65906"
        }
    }

    @IBAction func qrcodeButton(_ sender: UIButton) {
        performSegueWithIdentifier(identifier: "ViewControllerSwizzler2", sender: sender) { segue in
            let vc = segue.destination as? ViewControllerSwizzler2
            vc?.boxItem = "QR-код"
            vc?.boxItemImage = "qrcodescan_120401"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
}
