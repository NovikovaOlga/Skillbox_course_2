

import UIKit
import Firebase
import Messages
import FirebaseMessaging

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Messaging.messaging().subscribe(toTopic: "weather") { error in
          print("Subscribed to weather topic")
        }
    }
        
    public func alert(popupText: String, popupButton: String) {
        let alertController = UIAlertController(title: "Push notification", message: "", preferredStyle: .alert)
                
        let action1 = UIAlertAction(title: "\(popupText)", style: .default) { (action:UIAlertAction) in
            print("popupText tap")
        }

        let action2 = UIAlertAction(title: "\(popupButton)", style: .default) { (action:UIAlertAction) in
            print("popupButton tap")
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //alert(popupText: "test1", popupButton: "test2")
    }
}

