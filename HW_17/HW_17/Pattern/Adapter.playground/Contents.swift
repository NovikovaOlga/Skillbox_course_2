// MARK: - Adapter

//Адаптер — это структурный паттерн проектирования, который позволяет объектам с несовместимыми интерфейсами работать вместе.

// Пример: почтовый сортировщик для перевода написанного адреса получателя в координаты (пример хоть и перевода String в String, но это адаптер адреса, написанного человеком, в координаты - распознаваемые сортировщиком

import MapKit
import CoreLocation

// Формат, с которым работаем
class Location { // Адрес с широтой и долготой
    internal var locationFormat = "lat: lat, lon: lon"
    
    func locationOut() -> String {
        return locationFormat
    }
}

// Преобразуемый формат
class PostalAddress { // адрес на конверте (привычный человеку)
    func locationIn() -> String {
        let address = "1 Infinite Loop, Cupertino, CA 95014"
        return address
    }
}

class Adapter: Location {
    
    private var postalAddress: PostalAddress
    
    init(_ postalAddress: PostalAddress) {
        self.postalAddress = postalAddress
    }
    
    override func locationOut() -> String {

        var location = ""
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(postalAddress.locationIn()) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
            location = "Lat: \(String(describing: lat)), Lon: \(String(describing: lon))"
        }
        return location
    }
}

class Addressees { // получатель
    internal static func execute(location: Location) {
        print(location.locationOut())
    }
}

class AdapterConceptual {
    func testAdapterConceptual() {
        print("Addressees: получены данные с адресом! Обращаемся к Location за инструкцией!")
        Addressees.execute(location: Location())

        let postalAddress = PostalAddress()
        print("Addressees: у PostalAddress не согласованный формат, требуется преобразование.")
        print("PostalAddress: " + postalAddress.locationIn().description)

        print("Addressees: применение Adapter")
        Addressees.execute(location: Adapter(postalAddress))
    }
}

let test = AdapterConceptual()
test.testAdapterConceptual()


// 37.333362, -122.031180
// 1 Infinite Loop, Cupertino, CA 95014
