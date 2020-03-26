//
//  NSObject+Extension.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

extension NSObject {
    static var name: String {
        return String(describing: self)
    }
}
