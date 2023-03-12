
import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {

 //   let locationManager = CLLocationManager()
    let marker = GMSMarker() // мы тут
    let dots = DotData.dots // наши точки (онли хорошие)
    var zoom: Float = 15 // будем двигать плюс минус
 
    @IBAction func plusButton(_ sender: Any) {
        
        zoom += 0.2
        
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 40.75921, longitude: -73.98464), zoom: zoom)
    }
    
    @IBAction func youButton(_ sender: Any) {
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 40.75921, longitude: -73.98464), zoom: zoom)
    }
    
    @IBAction func minusButton(_ sender: Any) {
        zoom -= 0.2
        
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 40.75921, longitude: -73.98464), zoom: zoom)
    }
  
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // настроим камеру
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 40.75921, longitude: -73.98464), zoom: zoom)
        
        //местоположение пользователя
        marker.position = CLLocationCoordinate2D(latitude: 40.75921, longitude: -73.98464)
        marker.title = "Вы здесь"
        marker.snippet = "Оставайтесь незаметными"
        marker.icon = UIImage(named: "youGoogle")
        marker.map = mapView // маркеру назначим карту (в отличии от AppleMaps, где карте назначали маркер)
        
        // остальные точки (оставить только хорошие)
        for dot in dots {
            if dot.status == "можно" {
                let marker = DotGMSMarker(dot: dot)
                marker.map = mapView
            }
        }
    }
}

extension GoogleMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        guard let dotMarker = marker as? DotGMSMarker,
              let dotTitle = dotMarker.dot.title else {
            return false
        }
        print("Вы выбрали: " + dotTitle)
        return false
    }
    
}
