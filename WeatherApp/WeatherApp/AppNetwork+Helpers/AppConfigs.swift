//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

let apiKey = "287247cce4410857d4e8ae6c74d9ac01"

class AppConfigs {

// MARK: - Properties
    fileprivate init() {}
    static let shared: AppConfigs = AppConfigs()
    var shouldPrintLogs = false
}
