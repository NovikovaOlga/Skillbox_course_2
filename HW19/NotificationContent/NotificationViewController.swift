
import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likeButton.setTitle("♥︎", for: .normal)
    }
    
    @IBAction func openAppButton(_ sender: Any) {
        openApp()
    }
    
    func openApp() { // открыть приложение по тапу на уведомлении
        extensionContext?.performNotificationDefaultAction()
    }
    
    func dismissNotification() { //
        extensionContext?.dismissNotificationContentExtension()
    }

  
    
    
}
