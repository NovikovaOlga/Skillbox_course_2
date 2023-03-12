import Foundation
import MapKit
import Contacts // Это добавляет фреймворк контактов, который содержит константы ключей словаря, такие как CNPostalAddressStreetKey, для тех случаев, когда вам нужно установить поля адреса, города или штата местоположения.

class Dot: NSObject, MKAnnotation {
    let status: String? // метса хорошие(для гугл) и плохие(для яндекс)
    let title: String? // верхняя строчка (толтый шрифт)
    let locationName: String? // нижняя строчка на ярлыке (мелкий шрифт
    let discipline: String? // иконка или цвет булавки
    let coordinate: CLLocationCoordinate2D // координаты
    
    init(
        status: String?,
        title: String?,
        locationName: String?,
        discipline: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.status = status
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(feature: MKGeoJSONFeature) { // MapKit имеет MKGeoJSONDecoder, супер-полезную функцию. Он может декодировать данные GeoJSON и возвращать массив объектов, реализующих протокол MKGeoJSONObject. MapKit также предоставляет один конкретный класс, который реализует этот протокол: MKGeoJSONFeature, который - это все, что вам понадобится для этого учебника.
        // 1 MKGeoJSONFeatureимеет свойство geometry, представляющее одну или несколько фигур, связанных с элементом. Все функции в Annotation.geojson являются местоположениями точек, и MapKit поможет вам создать MKPointAnnotation. Здесь вы найдете координату в виде CLLocationCoordinate2D.
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties, // Затем вы читаете properties функции, которая относится к Data? и содержит сериализованный словарь JSON. Вы используете JSONSerialization для декодирования данных в словарь Swift.
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
        else {
            return nil
        }
        
        // 3 Теперь, когда свойства декодированы, вы можете задать соответствующие свойства Artwork из значений словаря.
        status = properties["status"] as? String
        title = properties["title"] as? String
        locationName = properties["location"] as? String
        discipline = properties["discipline"] as? String
        coordinate = point.coordinate
        super.init()
    }
    
    var subtitle: String? { // подзаголовок
        return locationName
    }
    // Вы используете существующую информацию о местоположении в качестве адреса для создания метки MKPlacemark. Затем вы создаете и настраиваете MKMapItem, необходимый для связи с Maps.
    var mapItem: MKMapItem? {
        guard let location = locationName else {
            return nil
        }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    var image: UIImage {
        guard let name = discipline else {
            return #imageLiteral(resourceName: "Flag")
        }
        
        switch name {
        case "zombieType1":
            return #imageLiteral(resourceName: "zombieType1")
        case "cicada2":
            return #imageLiteral(resourceName: "cicada2")
        case "attention":
            return #imageLiteral(resourceName: "attention")
        case "shop":
            return #imageLiteral(resourceName: "shop")
        case "safe":
            return #imageLiteral(resourceName: "safe")
        case "food":
            return #imageLiteral(resourceName: "food")
        case "pizza":
            return #imageLiteral(resourceName: "pizza")
        default:
            return #imageLiteral(resourceName: "Flag")
        }
    }
}
