/*
 *	JSONUtility.swift
 //  WeatherApp
 //
 //  Created by Rohit Singh on 25/03/2020.
 //  Copyright © 2020 SMD. All rights reserved.
 */

import UIKit
@testable import WeatherApp
// MARK: - Definitions -

// MARK: - Type -
public typealias JSON = [String : Any]

class JSONUtility {

// MARK: - Properties

// MARK: - Constructors
    static func jsonDictionary(with file: String) -> [String : Any] {
        
        let bundle = Bundle(for: JSONUtility.self)
        guard let file = bundle.path(forResource: file, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: file), options: []),
            let object = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let validObject = object as? JSON else {
                return [:]
        }
        
        return validObject
    }
    
    static func jsonData(with filename: String) -> Data {
        let bundle = Bundle(for: JSONUtility.self)
        let path = bundle.url(forResource: filename, withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }
}
