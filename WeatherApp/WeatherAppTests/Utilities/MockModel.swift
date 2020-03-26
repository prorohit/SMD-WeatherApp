//
//  MockModelFormatter.swift
//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import XCTest
@testable import WeatherApp

class MockModel {
    
    static func format<T: Codable>(fileName: String, type: T.Type) -> T {
        let json = JSONUtility.jsonData(with: fileName)
        let model = try! JSONDecoder().decode(T.self, from: json)
        return model
    }
    
}
