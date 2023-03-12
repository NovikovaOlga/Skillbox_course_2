
import UIKit

class LoginController: UIViewController {
    
    let startAnimator = StartAnimator()

    @IBOutlet weak var artImage: UIImageView!
    
    @IBOutlet weak var zombieIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        artImage.alpha = 0.0
        zombieIcon.alpha = 0.0
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            self.startAnimator.moveImage(image: self.artImage, icon: self.zombieIcon)
            self.startAnimator.starShadowAnimate(shadow: self.zombieIcon)
        }
    }
}
