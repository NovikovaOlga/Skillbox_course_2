// b) загрузку изображения, применение к нему эффекта размытия в фоновом потоке и показ на экране;
import UIKit

class ViewControllerB: UIViewController {
    
    let imageURL = "https://pbs.twimg.com/media/Ev2Zy5YWEAIR_te.jpg"
    
    var boxBlurEffect: Bool = false
    
    @IBAction func loadingImage(_ sender: Any) {
        
        let url = URL(string: imageURL)!
        
        DispatchQueue.global(qos: .utility).async {
            let data = (try! Data(contentsOf: url))
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                
                self.imageView.image = image
                if self.boxBlurEffect == false {
                    let blurEffect = UIBlurEffect(style: .regular)
                    let blurEffectImageView = UIVisualEffectView(effect: blurEffect)
                    blurEffectImageView.frame = self.imageView.frame
                    
                    self.view.addSubview(blurEffectImageView)
                    self.boxBlurEffect = true
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
    }
}
