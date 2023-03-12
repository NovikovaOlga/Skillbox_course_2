
import UIKit
import GoogleMaps

final class StartAnimator {

    // движение заставки, появление кнопки
   func moveImage(image: UIImageView, icon: UIImageView ) {
       UIView.animate(withDuration: 0.5, animations: {
            image.alpha = 1.0
            
        })
        UIView.animate(withDuration: 2, animations: {
            image.transform = CGAffineTransform(translationX: -350, y: 0)
            
        }){(isCompeted) in
            UIView.animate(withDuration: 1, animations: {
                icon.alpha = 1.0
            })
        }
    }
    
    // кнопка мерцает
    func starShadowAnimate(shadow: UIView) { // кнопка пульсирует
        UIView.animate(withDuration: 1.6, delay: 0, options: [.repeat, .autoreverse], animations: {
            shadow.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // был 1.1
        })
    }
}
