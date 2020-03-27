//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation
import UIKit

protocol CityWeatherFetchable {
    func fetchWeather(for city: String, completion: @escaping ([CityResponseModel]?) -> (Void))
}

class CityViewModel {
    
    fileprivate var cityResponseModels: [CityResponseModel]?
    fileprivate var updatedText: String?
    fileprivate let minNumberOfCitiesAllowed = 3
    fileprivate let maxNumberOfCitiesAllowed = 7
    fileprivate var cityNames = [String]()
    
    func saveEnteredText(_ text: String) {
        updatedText = text
    }
    
    func canEnterMoreCities() -> Bool {
        guard let text = updatedText else {
            return true
        }
        return text.count(of: ",") <= (maxNumberOfCitiesAllowed - 1)
    }
    
    func validateInput(text: String = "") -> (Bool, String?, UIColor) {
        var validation: Bool = true
        var message: String?
        var color = UIColor.red
        if !canEnterMoreCities() {
            validation = false
            message = "Input of min. 3 and max. 7 number of cities is allowed only."
        } else if extractCityNames().count < minNumberOfCitiesAllowed {
            validation = false
            message = "Minimum 3 number of cities separated by comma is required."
            color = UIColor(red: 0, green: 76/255.0, blue: 0, alpha: 1.0)
        }
        return (validation, message, color)
    }
    
    @discardableResult
    func extractCityNames() -> [String] {
        guard let text = updatedText else {
            return []
        }
        cityNames = text.components(separatedBy: ",")
        if cityNames.count > maxNumberOfCitiesAllowed {
            cityNames.remove(at: maxNumberOfCitiesAllowed)
        }
        cityNames = cityNames.filter({ $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0})
        return cityNames
        
    }
    
}

//MARK: Network API Calls
extension CityViewModel: CityWeatherFetchable {
    
    func resetDataSource() {
        cityResponseModels = nil
        cityResponseModels = []
    }
    
    func fetchWeather(for city: String, completion: @escaping ([CityResponseModel]?) -> (Void)) {
        AppNetworkManager().processAPI(CityService.getWeather(city: city),
                                       modelType: CityResponseModel.self) { [weak self] (response) in
                                        switch response {
                                        case .success(let model):
                                            self?.perpareDataSource(model: model)
                                            break
                                        case .failure(_):
                                            break
                                        }
                                        completion(self?.cityResponseModels )
        }
    }
    
    func perpareDataSource(model: CityResponseModel) {
        self.cityResponseModels?.append(model)
    }
    
    var numberOfSections: Int {
        return cityResponseModels?.count ?? 0
    }
    
    var numberOfRows: Int {
        //1. Min Temp,
        //2. Max Temp,
        //3. Weather Description,
        //4. Wind Speed
        return 4
    }
    
    func sectionTitle(for index: Int) -> String? {
        return cityResponseModels?[safe: index]?.name
    }
    
    func tempInfo(at index: Int) -> (min: Double?, max: Double?) {
        return (cityResponseModels?[safe: index]?.main?.tempMin, cityResponseModels?[safe: index]?.main?.tempMax)
    }
    
    func weatherDescription(for index: Int) -> String? {
        return cityResponseModels?[safe: index]?.weather?.first?.weatherDescription
    }
    
    func windSpeed(for index: Int) -> Double? {
        return cityResponseModels?[safe: index]?.wind?.speed
    }
}
