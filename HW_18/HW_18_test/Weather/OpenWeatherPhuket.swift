import UIKit
import Alamofire

// &units=metric градусы в цельсиях, а не в кельвинах
var weather_url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=7.830441&lon=98.298781&appid=053f04c8d52212eafda9e89bd26642bf&units=metric")!

class AFrequest {
    func openweathermap(completition: @escaping ([Weather]) -> Void) {
        AF.request(weather_url).responseJSON { response in
            if let data = response.data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDict = json as? NSDictionary,
                        let hourly = jsonDict["hourly"] as? [NSDictionary] {
                            var results: [Weather] = []
                                for data in hourly {
                                    if let weatherDict = Weather(data: data) {
                                        results.append(weatherDict)
                                    }
                                }
                DispatchQueue.main.async {
                    completition(results)
                }
            } else {
                print("Error: response data nil")
            }
        }
    }
}

struct Weather {
    
    let weather: Current
        
    init?(data: NSDictionary) {
        guard let weather = Current(data: data) else { return nil }
        self.weather = weather
    }
}

struct Current {
    var date: String
    var temp: Double
    var windSpeed: Double
    var rain: Double = 0.0

    init?(data: NSDictionary) {
        guard
            let dt = data["dt"] as? Int,
            let temp = data["temp"] as? Double,
            let windSpeed = data["wind_speed"] as? Double
                
        else {
            preconditionFailure("NSDictionary error")
        }
            
        if let rain = data["rain"] as? NSDictionary {
            self.rain = rain["1h"] as? Double ?? 0.0
        }
            
        self.temp = Double(String(format: "%.2f", temp))!
        self.windSpeed = windSpeed
            
        func dt_convert(dt: Int) -> String {
            let date = Date(timeIntervalSince1970: TimeInterval(dt))
            let formatter = DateFormatter()
            formatter.timeZone = .autoupdatingCurrent
            formatter.locale = .autoupdatingCurrent
            formatter.dateFormat = "dd.MM.YY HH:mm"
            return formatter.string(from: date)
        }
        self.date = dt_convert(dt: dt)
    }
}
