
import UIKit
import MapKit

class AppleMapViewController: UIViewController {
    
    struct Constants {
        struct MapViewIdentifiers {
            static let sonarView = "sonarView"
        }
    }
    
    var regionRadius: CLLocationDistance = 1500
    let initialLocation = CLLocation(latitude: 40.75921, longitude: -73.98464)
    
    @IBOutlet private var mapView: MKMapView!

    @IBAction func plusButton(_ sender: Any) {
        regionRadius -= 100
        centerToLocation(initialLocation)
    }
    
    @IBAction func you(_ sender: Any) { // вернемся на точку пользователя
        centerToLocation(initialLocation)
    }
    
    @IBAction func minusButton(_ sender: Any) {
            regionRadius += 100
            centerToLocation(initialLocation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // центрирование карты по координатам
        centerToLocation(initialLocation)
        
        //ограничим зуммирование (регион не станет слишком маленьким)
        let regionCenter = CLLocation(latitude: 40.95301, longitude: -74.11994)
        let region = MKCoordinateRegion(
            center: regionCenter.coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000)
        mapView.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        mapView.delegate = self
        
        // Показать пользователя на карте (без geojson)
        let userDot = UserDot(
            title: "Вы здесь",
            locationName: "Текущее положение пользователя",
            coordinate: CLLocationCoordinate2D(latitude: 40.75921, longitude: -73.98464))
        mapView.addAnnotation(userDot)
        
        //класс с идентификатором повторного использования представления карты по умолчанию
        mapView.register(
          DotView.self,
          forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.addAnnotations(DotData.dots)
    }
  
    // настройка региона
    func centerToLocation(_ location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius, // ограничения региона по ширине
            longitudinalMeters: regionRadius) // огрнаичение региона по долготе
        mapView.setRegion(coordinateRegion, animated: true) // автоматический перевод карты в регион масштабирования
    }
}

extension AppleMapViewController: MKMapViewDelegate {
    
    // MARK: делегат Dot
    // обработка выноски
    func mapView( // этикетка точки и переход в карты для построения маршрута
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl
    ) {
        guard let dot = view.annotation as? Dot else { // захват Dot, запуск карты, создание связанный элемент MKMapItem и вызов openInMaps(launchOptions:) в элементе карты.
            return
        }
        // передача словаря.
        let launchOptions = [ //показать маршруты движения
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking // пешком-пешком
        ]
        dot.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
    // Делегат userDot
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation // вызывается для каждой аннотации, которую мы добавляем (
    ) -> MKAnnotationView? {
        // если  аннотация - объект Dot, то идем дальше, если не Dot (UserDot), то выполним sonar
        guard let annotation = annotation as? UserDot else {
            return nil
        }
        var userDotView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.MapViewIdentifiers.sonarView)
        
        if userDotView == nil {
            userDotView = SonarView(annotation: annotation, reuseIdentifier: Constants.MapViewIdentifiers.sonarView)
        } else {
            userDotView!.annotation = annotation
        }
        return userDotView
    }
}
