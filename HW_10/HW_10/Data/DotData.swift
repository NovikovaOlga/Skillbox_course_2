import UIKit
import MapKit
import CoreLocation

class DotData {
    
    private static var _dots: [Dot] = []
    
    static var dots: [Dot] {
        guard _dots.count == 0 else { return _dots }
        return loadInitialData()
    }
 
    private static func loadInitialData() -> [Dot] {
        guard
            let fileName = Bundle.main.url(forResource: "MapDot", withExtension: "geojson"),
            let dotsData = try? Data(contentsOf: fileName)
        else {
            return []
        }
        do {
            let features = try MKGeoJSONDecoder()
                .decode(dotsData)
                .compactMap { $0 as? MKGeoJSONFeature }
            let validWorks = features.compactMap(Dot.init)
            _dots.append(contentsOf: validWorks)
        } catch {
            print("Unexpected error: \(error).")
        }
        
        return _dots
    }
}
