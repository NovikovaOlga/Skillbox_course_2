
import XCTest
import Quick
import Nimble
import OHHTTPStubs
@testable import HW_18_test

class OpenWeatherPhuketTest: QuickSpec {
    override func setUp() { }
    
    override func tearDown() {
        HTTPStubs.removeAllStubs()
    }
    
    override func spec() {
        
        let stringPath = Bundle.main.path(forResource: "weatherPhuket", ofType: "json")!
        stub(condition: isPath(stringPath) && pathEndsWith("weatherPhuket.json")) { test in
            guard let path = OHPathForFile("weatherPhuket.json", type(of: self)) else {
                preconditionFailure("Can't find 'weatherPhuket.json'")
            }
            print("TEST URL: \(test)\n")
            return HTTPStubsResponse(fileAtPath: path,
                                     statusCode: 200,
                                     headers: ["Content-Type": "application/json"]).requestTime(1.0, responseTime: 1.0)
        }
        
        var weather: [Weather] = []
        let exp = expectation(description: "AFrequest")
        describe("AFrequest test") {
            let stringPath = Bundle.main.path(forResource: "weatherPhuket", ofType: "json")!
            weather_url = URL(fileURLWithPath: stringPath)
            
            waitUntil { done in
                AFrequest().openweathermap { result in
                    weather = result
                    it("check path") {
                        print("URL: \(weather_url)\n")
                    }
                    
                    it("check weather json") {
                        expect(weather.count).notTo(beNil())
                        print("weather.count: \(weather.count)\n")
                    }
                    it("check date") {
                        expect(weather[1].weather.date).notTo(beNil())
                        print("weather[1].forecast.date: \(weather[1].weather.date)\n")
                    }
                    
                    it("check temp") {
                        expect(weather[2].weather.temp).notTo(beNil())
                        print("weather[2].forecast.temp: \(weather[2].weather.temp)\n")
                    }
                    
                    it("check wind speed") {
                        expect(weather[3].weather.windSpeed).notTo(beNil())
                        print("weather[3].forecast.windSpeed: \(weather[3].weather.windSpeed)\n")
                    }
                    
                    it("check rain") {
                        expect(weather[4].weather.rain).notTo(beNil())
                        print("weather[4].forecast.rain: \(weather[4].weather.rain)\n")
                    }
                    exp.fulfill()
                }
                done()
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}


