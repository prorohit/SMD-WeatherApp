//
//  CityViewController+UITableView.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

fileprivate extension String {
    static let gpsCellReusableIdentifier = "GPSWeatherTableViewCell"
}

extension GPSViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gpsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gpsViewModel.numberOfRows(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .gpsCellReusableIdentifier, for: indexPath) as? GPSWeatherTableViewCell else {
            return UITableViewCell()
        }
       
        cell.setupCell(with: gpsViewModel.weatherDescription(for: indexPath),
                       minTemp: gpsViewModel.tempInfo(at: indexPath).min,
                       maxTemp: gpsViewModel.tempInfo(at: indexPath).max,
                       windSpeed: gpsViewModel.windSpeed(for: indexPath))
        cell.selectionStyle = .none

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = Bundle.main.loadNibNamed(CityNameSectionTitleView.name, owner: self, options: nil)?.first as? CityNameSectionTitleView else {
            return nil
        }
        let sectionInfo = gpsViewModel.sectionTitle(for: section)
        view.backgroundColor = .lightText
        view.setUpSection(with: sectionInfo)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  50.0
    }
}
