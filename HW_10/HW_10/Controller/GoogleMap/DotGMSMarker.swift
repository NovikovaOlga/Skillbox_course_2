import Foundation
import GoogleMaps

final class DotGMSMarker: GMSMarker {
    let dot: Dot
    
    init(dot: Dot) {
        self.dot = dot
        super.init()
        
        position = dot.coordinate
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
        title = dot.title
        snippet = dot.subtitle
        
        icon = dot.image
    }
}


