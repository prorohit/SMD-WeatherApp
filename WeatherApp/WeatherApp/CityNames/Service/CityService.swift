//
//  CityService.swift
//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

enum CityService: Buildable {
    case getWeather(city: String)
    
    var version: String {
        return "2.5"
    }
    
    var requestBody: [String : Any]? {
        return nil
    }
    
    var subPath: SubPathType {
        return .cityInfo
    }
    
    var endPoint: String {
        switch self {
        case .getWeather(let city):
            return "?q=\(city)"
        }
        
    }

}
