//
//  GPSViewModel.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

struct DataSource {
    let date: String
    let lists: [List]
}

protocol GPSWeatherFetchable {
    func fetchGPSWeather(for city: String, completion: @escaping ([DataSource]?) -> (Void))
}

final class GPSViewModel {
    
    fileprivate var cityListResponseModels: [List]?
    var filteredDataSource = [DataSource]()
    
    var numberOfSections: Int {
        return filteredDataSource.count
    }
    
    func numberOfRows(for index: Int) -> Int? {
        return filteredDataSource[safe: index]?.lists.count
    }
    
    func sectionTitle(for index: Int) -> String? {
        return filteredDataSource[safe: index]?.date
    }

    func tempInfo(at indexPath: IndexPath) -> (min: Double?, max: Double?) {
        return (filteredDataSource[safe: indexPath.section]?.lists[safe: indexPath.row]?.main?.tempMin, filteredDataSource[safe: indexPath.section]?.lists[safe: indexPath.row]?.main?.tempMax)
    }

    func weatherDescription(for indexPath: IndexPath) -> String? {
        return filteredDataSource[safe: indexPath.section]?.lists[safe: indexPath.row]?.weather?.first?.weatherDescription
    }

    func windSpeed(for indexPath: IndexPath) -> Double? {
        return filteredDataSource[safe: indexPath.section]?.lists[safe: indexPath.row]?.wind?.speed
    }
}

extension GPSViewModel: GPSWeatherFetchable {
   
    func resetGPSWeatherDataSource() {
        cityListResponseModels = nil
        cityListResponseModels = []
    }
    
    func fetchGPSWeather(for city: String, completion: @escaping ([DataSource]?) -> (Void)) {
        AppNetworkManager().processAPI(GPSWeatherService.getGPSWeather(city: city),
                                       modelType: GPSResponseModel.self) { [weak self] (response) in
                                        self?.resetGPSWeatherDataSource()
                                        switch response {
                                        case .success(let model):
                                            guard let lists = model.list else {
                                                completion(nil)
                                                return
                                            }
                                            self?.filteredDataSource = self?.transformingDataIntoPresentableState(lists: lists) ?? []
                                            break
                                        case .failure(_):
                                            break
                                        }
                                        completion(self?.filteredDataSource)
        }
    }

    func transformingDataIntoPresentableState(lists: [List]) -> [DataSource] {
        self.transformDataSource(lists: lists)
        return self.prepareFilteredDataSource(uniqueDates: self.findUniqueDates())
    }
    
    fileprivate func transformDataSource(lists: [List]) {
        for (_, var val) in lists.enumerated() {
            guard let str = val.dtTxt,
                let date = str.toDate() else {
                    return
            }
            val.dtTxt = date.toString()
            cityListResponseModels?.append(val)
        }
    }
    
    
    fileprivate func findUniqueDates() -> [String] {
        var uniqueValues = [String]()
        guard let lists = cityListResponseModels else {
            return uniqueValues
        }
        lists.forEach { (list) in
            if !uniqueValues.contains(list.dtTxt ?? "") {
                uniqueValues.append(list.dtTxt ?? "")
            }
        }
        return uniqueValues
    }
    
    fileprivate func prepareFilteredDataSource(uniqueDates: [String]) -> [DataSource] {
        var filteredData = [DataSource]()
        guard let lists = cityListResponseModels else {
            return filteredData
        }
        uniqueDates.forEach { (uniqueValue) in
            let filteredArray = lists.filter({($0.dtTxt ?? "") == uniqueValue})
            filteredData.append(DataSource(date: uniqueValue, lists: filteredArray))
        }
        return filteredData
    }
}
