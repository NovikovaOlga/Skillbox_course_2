import UIKit
import MapKit

class SonarView: MKAnnotationView {
    
    struct Constants {
        struct ColorPalette {
        //    static let green = UIColor(red:0.00, green:0.87, blue:0.71, alpha:1.0)
            static let green = UIColor(red:0.87, green:0.01, blue:0.01, alpha:1.0)
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sonar(_ beginTime: CFTimeInterval) {
        //Круг в его самом маленьком размере.
        
        let circlePath1 = UIBezierPath(arcCenter: self.center, radius: CGFloat(3), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)

        // Круг в его самом большом размере.
        let circlePath2 = UIBezierPath(arcCenter: self.center, radius: CGFloat(40), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        // Настройте слой.
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = Constants.ColorPalette.green.cgColor
        shapeLayer.fillColor = Constants.ColorPalette.green.cgColor
        
        // Это путь, который виден, когда не было бы анимации.
        shapeLayer.path = circlePath1.cgPath
        self.layer.addSublayer(shapeLayer)
        
        // Оживите путь.
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = circlePath1.cgPath
        pathAnimation.toValue = circlePath2.cgPath
        
        // Анимируйте альфа-значение.
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.8
        alphaAnimation.toValue = 0
        
        //Мы хотим, чтобы анимация пути и альфа-анимации идеально сочетались, поэтому
        // мы помещаем их в группу анимации.
        let animationGroup = CAAnimationGroup()
        animationGroup.beginTime = beginTime
        animationGroup.animations = [pathAnimation, alphaAnimation]
        animationGroup.duration = 2.76
        animationGroup.repeatCount = FLT_MAX
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = CAMediaTimingFillMode.forwards
        
        // Добавьте анимацию в слой.
        shapeLayer.add(animationGroup, forKey: "sonar")
    }
    
    func startAnimation() {
        sonar(CACurrentMediaTime())
        sonar(CACurrentMediaTime() + 0.92)
        sonar(CACurrentMediaTime() + 1.84)
    }
    
}
