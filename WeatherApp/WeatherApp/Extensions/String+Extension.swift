//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}
