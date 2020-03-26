//
//  CityViewController+UITableView.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

fileprivate extension String {
    static let cityCellReusableIdentifier = "cityCellReusableIdentifier"
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .cityCellReusableIdentifier) else {
                return UITableViewCell(style: .default, reuseIdentifier: .cityCellReusableIdentifier)
            }
            return cell
        }()
        switch indexPath.row {
        case 0:
            
            cell.textLabel?.text = "Weather Description: \n"
                + (cityViewModel.weatherDescription(for: indexPath.section) ?? "N/A").capitalized
        case 1:
            cell.textLabel?.text = "Min Temp: \n"
                +  "\(cityViewModel.tempInfo(at: indexPath.section).min ?? 0)"
        case 2:
            cell.textLabel?.text = "Max Temp: \n"
                + "\(cityViewModel.tempInfo(at: indexPath.section).max ?? 0)"
        case 3:
            cell.textLabel?.text = "Wind speed: \n"
                + "\(cityViewModel.windSpeed(for: indexPath.section) ?? 0)"
        default:
            break
        }
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = Bundle.main.loadNibNamed(CityNameSectionTitleView.name, owner: self, options: nil)?.first as? CityNameSectionTitleView else {
            return nil
        }
        let sectionInfo = cityViewModel.sectionTitle(for: section)
        view.backgroundColor = .lightText
        view.setUpSection(with: sectionInfo)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  50.0
    }
}
