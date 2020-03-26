//
//  GPSWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

class GPSWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var weatherLabel: UILabel!
    @IBOutlet fileprivate weak var minTempLabel: UILabel!
    @IBOutlet fileprivate weak var maxTempLabel: UILabel!
    @IBOutlet fileprivate weak var windSpeedLabel: UILabel!
    
    func setupCell(with weatherDesc: String?,
                   minTemp: Double?,
                   maxTemp: Double?,
                   windSpeed: Double?) {
        
        weatherLabel.text = "Weather Description: \n"
            + (weatherDesc ?? "N/A").capitalized
        
        minTempLabel.text = "Min Temp: \n"
            +  "\(minTemp ?? 0)"
        maxTempLabel.text = "Max Temp: \n"
            +  "\(maxTemp ?? 0)"
        
        windSpeedLabel.text = "Wind speed: \n"
            + "\(windSpeed ?? 0)"
        
    }
    
    
}
