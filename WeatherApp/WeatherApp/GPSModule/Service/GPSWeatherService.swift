//
//  GPSWeatherService.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

enum GPSWeatherService: Buildable {
    case getGPSWeather(city: String)
    
    var version: String {
        return "2.5"
    }
    
    var requestBody: [String : Any]? {
        return nil
    }
    
    var subPath: SubPathType {
        return .gpsLocationInfo
    }
    
    var endPoint: String {
        switch self {
        case .getGPSWeather(let city):
            return "?q=\(city)"
        }
        
    }
    
}
