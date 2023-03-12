import Foundation
import MapKit
import Contacts // фреймворк контактов (содержит константы ключей словаря - CNPostalAddressStreetKey, если нужно установить поля адреса, города или штата местоположения).
import GoogleMaps

class UserDot: NSObject, MKAnnotation { // точка пользователя
    let title: String? // заголовок
    let locationName: String?
    let coordinate: CLLocationCoordinate2D // координаты
    
    init(
        title: String?,
        locationName: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    

//    var subtitle: String? { // подзаголовок
//        return locationName
//    }
//    // Вы используете существующую информацию о местоположении в качестве адреса для создания метки MKPlacemark. Затем вы создаете и настраиваете MKMapItem, необходимый для связи с Maps.
//    var mapItem: MKMapItem? {
//        guard let location = locationName else {
//            return nil
//        }
//        
//        let addressDict = [CNPostalAddressStreetKey: location]
//        let placemark = MKPlacemark(
//            coordinate: coordinate,
//            addressDictionary: addressDict)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = title
//        return mapItem
//    }
} 
