//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//


import Foundation

public struct AppEnvironment {
    
    static var baseURL: String {
        #if DEBUG
        return ""
        #else
        return ""
        #endif
    }
}
