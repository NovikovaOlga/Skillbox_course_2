import Foundation
import MapKit


class DotView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let dot = newValue as? Dot else {
                return
            }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            //   rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            //Правый аксессуар выноски является информационной кнопкой, значок Карты.
            let mapsButton = UIButton(frame: CGRect(
                origin: CGPoint.zero,
                size: CGSize(width: 48, height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton
            
            image = dot.image
            
            // Теперь вам нужна многострочная метка.
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = dot.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}

