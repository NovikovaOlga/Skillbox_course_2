
import UIKit

// a) загрузку изображения в фоновом потоке и показ его на экране.

/* из яндекс картинок (лучше https)
https://pbs.twimg.com/media/Ev2Zy5YWEAIR_te.jpg
 
https://www.boxofficepro.com/wp-content/uploads/2021/02/Raya-and-the-Last-Dragon-cropped-from-official-poster-768x872.jpg
*/

class ViewControllerA: UIViewController {
    
    let imageURL = "https://pbs.twimg.com/media/Ev2Zy5YWEAIR_te.jpg"
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func loadingImage(_ sender: Any) {
        
        let url = URL(string: imageURL)!
        DispatchQueue.global(qos: .utility).async {
            let data = (try! Data(contentsOf: url))
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
    }
}
