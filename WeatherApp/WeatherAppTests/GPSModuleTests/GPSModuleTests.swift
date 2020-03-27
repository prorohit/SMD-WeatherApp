//
//  GPSModuleTests.swift
//  WeatherAppTests
//
//  Created by Rohit Singh on 27/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import XCTest
@testable import WeatherApp

class MockGPSWeatherInfo {
    func fetchGPSWeather(path: String) -> [DataSource] {
        let json = JSONUtility.jsonData(with: path)
        let datalogicModel = try! JSONDecoder().decode(GPSResponseModel.self, from: json)
        let gpsViewModel = GPSViewModel()
        gpsViewModel.resetGPSWeatherDataSource()
        return gpsViewModel.transformingDataIntoPresentableState(lists: datalogicModel.list!)
    }
}

class MockGPSWeatherSuccessFetchable: GPSWeatherFetchable {
    func fetchGPSWeather(for city: String, completion: @escaping ([DataSource]?) -> (Void)) {
        let model = MockGPSWeatherInfo().fetchGPSWeather(path: "gps_weather_success")
        completion(model)
    }
}

class MockGPSWeatherFailureFetchable: GPSWeatherFetchable {
    func fetchGPSWeather(for city: String, completion: @escaping ([DataSource]?) -> (Void)) {
        let model = MockGPSWeatherInfo().fetchGPSWeather(path: "gps_weather_failure")
        completion(model)
    }
}

class GPSModuleTests: XCTestCase {
    let viewModel = GPSViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGPSWeatherBuildable() {
        let buildable = GPSWeatherService.getGPSWeather(city: "Dubai")
        let lastComponent = "?q=Dubai"
        XCTAssert(buildable.endPoint.components(separatedBy: "/").last! == lastComponent)
        XCTAssert(buildable.version == "2.5")
        XCTAssert(buildable.subPath.value == "forecast")
        XCTAssert(buildable.url!.absoluteString.contains("appid=287247cce4410857d4e8ae6c74d9ac01"))
        XCTAssert(buildable.methodType == .get)
        XCTAssert(buildable.requestBody == nil)
    }

    
    func testSuccessGPSWeather() {
        let object = MockGPSWeatherSuccessFetchable()
        object.fetchGPSWeather(for: "Dubai") { (models) -> (Void) in
            // 6 Different dates are there in the response
            XCTAssert(models!.count == 6)
            self.viewModel.resetGPSWeatherDataSource()
            self.viewModel.filteredDataSource = models!
            XCTAssert(self.viewModel.numberOfSections == models!.count)
            XCTAssert(self.viewModel.numberOfRows(for: 0) == 6)
            XCTAssert(self.viewModel.numberOfRows(for: 1) == 8)
            XCTAssert(self.viewModel.numberOfRows(for: 2) == 8)
            XCTAssert(self.viewModel.numberOfRows(for: 3) == 8)
            XCTAssert(self.viewModel.numberOfRows(for: 4) == 8)
            XCTAssert(self.viewModel.numberOfRows(for: 5) == 2)

            XCTAssert(self.viewModel.sectionTitle(for: 0) == "2020-03-27")
            XCTAssert(self.viewModel.sectionTitle(for: 1) == "2020-03-28")
            XCTAssert(self.viewModel.sectionTitle(for: 2) == "2020-03-29")
            XCTAssert(self.viewModel.sectionTitle(for: 3) == "2020-03-30")
            XCTAssert(self.viewModel.sectionTitle(for: 4) == "2020-03-31")
            XCTAssert(self.viewModel.sectionTitle(for: 5) == "2020-04-01")

            XCTAssert(self.viewModel.weatherDescription(for: IndexPath(row: 0, section: 0)) == "few clouds")
            XCTAssert(self.viewModel.tempInfo(at: IndexPath(row: 0, section: 0)).min! == 297.79)
            XCTAssert(self.viewModel.tempInfo(at: IndexPath(row: 0, section: 0)).max! == 298.37)
            XCTAssert(self.viewModel.windSpeed(for: IndexPath(row: 0, section: 0))! == 4.32)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
