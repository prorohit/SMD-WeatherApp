//
//  CityWeatherTests.swift
//  WeatherAppTests
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import XCTest
@testable import WeatherApp

class MockCityWeatherInfo {
    func fetchCityWeather(path: String) -> [CityResponseModel]? {
        let json = JSONUtility.jsonData(with: path)
        let datalogicModel = try! JSONDecoder().decode(CityResponseModel.self, from: json)
        return [datalogicModel]
    }
}

class MockOrderSuccessFetchable: CityWeatherFetchable {
    func fetchWeather(for city: String, completion: @escaping ([CityResponseModel]?) -> (Void)) {
        let model = MockCityWeatherInfo().fetchCityWeather(path: "city_weather_success")
        completion(model)
    }
    
}

class MockOrderFailureFetchable: CityWeatherFetchable {
    func fetchWeather(for city: String, completion: @escaping ([CityResponseModel]?) -> (Void)) {
        let model = MockCityWeatherInfo().fetchCityWeather(path: "city_weather_failure")
        completion(model)
    }
}

class CityWeatherTests: XCTestCase {
    let viewModel = CityViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCityWeatherBuildable() {
        let buildable = CityService.getWeather(city: "Sharjah")
        let lastComponent = "?q=Sharjah"
        XCTAssert(buildable.endPoint.components(separatedBy: "/").last! == lastComponent)
        XCTAssert(buildable.version == "2.5")
        XCTAssert(buildable.subPath.value == "weather")
        XCTAssert(buildable.url!.absoluteString.contains("appid=287247cce4410857d4e8ae6c74d9ac01"))
        XCTAssert(buildable.methodType == .get)
        XCTAssert(buildable.requestBody == nil)
    }
    
    func testInValidMinEntry() {
        let exp = viewModel.validateInput(text: "A,,,,,,,,")
        XCTAssert(exp.0 == false)
    }
    
    func testInValidMaxEntry() {
        let exp = viewModel.validateInput(text: "Dubai,Goa,Delhi,China,Turkey,Russai,Punjab,Mumbai")
        XCTAssert(exp.0 == false)
    }
    
    func testValidMaxEntry() {
        let exp = viewModel.validateInput(text: "Dubai,Goa,Delhi,China,Turkey,Russai,Punjab")
        XCTAssert(exp.0 == false)
    }
    
    func testValidEntry() {
        viewModel.saveEnteredText("A,A,A,,")
        let exp = viewModel.validateInput(text: "A,A,A,,")
        XCTAssert(exp.0 == true)
    }

    func testSuccessCityWeather() {
        let object = MockOrderSuccessFetchable()
        object.fetchWeather(for: "Sharjah") { (models) -> (Void) in
            XCTAssert(models!.count > 0)
            XCTAssert(models!.first!.cod! == 200)
            XCTAssert(models!.first!.main != nil)
            // Temprature Tests
            XCTAssertNotNil(models!.first!.main!.tempMax)
            XCTAssertNotNil(models!.first!.main!.tempMin)
            XCTAssertNotNil(models!.first!.main!.temp)
            XCTAssertNotNil(models!.first!.main!.humidity)
            XCTAssertNotNil(models!.first!.main!.pressure)
            
            XCTAssert(models!.first!.main!.tempMax == 297.15)
            XCTAssert(models!.first!.main!.tempMin == 293.71)
            XCTAssert(models!.first!.main!.temp == 295.7)
            XCTAssert(models!.first!.main!.humidity == 53)
            XCTAssert(models!.first!.main!.pressure == 1014)
            
            // Wind Tests
            XCTAssertNotNil(models!.first!.wind)
            XCTAssertNotNil(models!.first!.wind?.speed)
            XCTAssertNotNil(models!.first!.wind?.deg)
            
            XCTAssert(models!.first!.wind?.speed == 2.6)
            XCTAssert(models!.first!.wind?.deg == 100)
            
            // Name Tests
            XCTAssertNotNil(models!.first!.name)
            XCTAssert(models!.first!.name == "Sharjah city")
            
            // Weather Description
            XCTAssertNotNil(models!.first!.weather!)
            XCTAssert(models!.first!.weather!.first!.weatherDescription == "few clouds")
        }
    }
    
    func testFailureCityWeather() {
        let object = MockOrderFailureFetchable()
        object.fetchWeather(for: "AOO") { (models) -> (Void) in
            XCTAssert(models!.first!.cod == 404)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
