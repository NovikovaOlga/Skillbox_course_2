
import UIKit
import YandexMapsMobile
import CoreLocation
//import MapKit

class YandexMapViewController: UIViewController{
   
    let dots = DotData.dots // наши точки (онли плохие)
    var zoom: Float = 15 // будем двигать плюс минус

    
    @IBOutlet weak var mapViewYandex: YMKMapView!

    @IBAction func plusButtonYandex(_ sender: Any) {
        zoom += 0.2
        mapViewYandex.mapWindow.map.move(
              with: YMKCameraPosition.init(target: YMKPoint(latitude: 40.75921, longitude: -73.98464), zoom: zoom, azimuth: 0, tilt: 0))
    }
    
    @IBAction func minusButtonYandex(_ sender: Any) {
        zoom -= 0.2
        mapViewYandex.mapWindow.map.move(
              with: YMKCameraPosition.init(target: YMKPoint(latitude: 40.75921, longitude: -73.98464), zoom: zoom, azimuth: 0, tilt: 0))
    }
    
    @IBAction func youButtonYandex(_ sender: Any) {  //поиск пользователя (анимацию убрала - утомляет)
        mapViewYandex.mapWindow.map.move(
              with: YMKCameraPosition.init(target: YMKPoint(latitude: 40.75921, longitude: -73.98464), zoom: 15, azimuth: 0, tilt: 0)) //, animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5), cameraCallback: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // настроим камеру (без анимации)
        mapViewYandex.mapWindow.map.move(
              with: YMKCameraPosition.init(target: YMKPoint(latitude: 40.75921, longitude: -73.98464), zoom: 15, azimuth: 0, tilt: 0))
        
        let mapObjects = mapViewYandex.mapWindow.map.mapObjects
        
        // пользователь
        mapObjects.addPlacemark(with: YMKPoint(latitude: 40.75921, longitude: -73.98464), image: UIImage(named: "youYandex")!)
        
        // ставим метки
        for dot in dots {
            if dot.status == "нельзя" {
                mapObjects.addPlacemark(with: YMKPoint(latitude: dot.coordinate.latitude, longitude: dot.coordinate.longitude), image: dot.image)
            }
            mapObjects.addTapListener(with: self)
        }
    }
}

extension YandexMapViewController: YMKMapObjectTapListener { // не работает
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        
        if let dot = mapObject as? YMKCircleMapObject {
            
            if let dot = dot.userData as? Dot, let title = dot.title {
                print("Вы выбрали: \(title)")
                
            }
        }
        return true
    }
}
