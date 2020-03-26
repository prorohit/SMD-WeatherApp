//
//  GPSViewController.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit
import CoreLocation

extension String {
    static let locationPermssionTitle = "Location permission"
    static let locationPermssionDescIfIphoneLocationIsOff =  "Please turn on the location permission in the iPhone \n [Settings -> Privacy -> Location Services]"
    static let locationPermissionDescIfAppLocationSettingsOff = "Please turn on the location access permission in the application settings \n [Settings -> WeatherApp -> Location]"
    static let settingActionTitle = "Settings"
    static let cancelActionTitle = "Cancel"
}

final class GPSViewController: AppBaseViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableViewInfo: UITableView!
    
    let gpsViewModel = GPSViewModel()
    //MARK: Location Service Variable
    let manager: CLLocationManager = CLLocationManager()
    var cityName: String?
    var isLocationServiceEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLocationServiceEnabled {
            showAlertIfLocationServicesDisabledInIphone()
        } else {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityNameLabel.text = nil
        cityName = nil
    }
    
    //MARK: Private Methods
    fileprivate func reverseGeocode(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard error == nil else {
                return
            }
            if let placemarks = placemarks,
                let currentPlacemark = placemarks.first,
                let cityName = currentPlacemark.locality?.lowercased(),
                self?.cityName == nil {
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.hidesWhenStopped = true
                self?.cityNameLabel.text = "Current City: " + cityName.capitalized
                self?.cityName = cityName
                self?.fetchInformation(of: cityName)
            }
        }
    }
    
    fileprivate func openSettingsApp() {
        if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    fileprivate func showAlertIfLocationServicesDisabledInIphone() {
        let alert =  AlertViewUtility(withGenericMode: .locationPermssionTitle,
                                      withMessage: .locationPermssionDescIfIphoneLocationIsOff,
                                      withActionTitles: [.settingActionTitle, .cancelActionTitle],
                                      withActionStyles: [.default, .cancel],
                                      withPreferredStyle: .alert) { [weak self] (index) in
                                        guard index == 0 else {
                                            return
                                        }
                                        self?.openSettingsApp()
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: Network API Calls
extension GPSViewController {
    fileprivate func fetchInformation(of cityName: String) {
        gpsViewModel.resetDataSource()
        AppLoader().showProgress(status: nil)
        gpsViewModel.fetchGPSWeather(for: cityName) { [weak self] (response) -> (Void) in
            AppLoader().hideProgress()
            DispatchQueue.main.async {
               self?.tableViewInfo.reloadData()
            }
        }
    }
}

//MARK: Location Service Delegates
extension GPSViewController: CLLocationManagerDelegate {
    fileprivate func showAlertIfApplicationLocationAccessIsOff() {
        // Go to App Settings and change location access permission
        let alert =  AlertViewUtility(withGenericMode: .locationPermssionTitle,
                                      withMessage: .locationPermissionDescIfAppLocationSettingsOff,
                                      withActionTitles: [.settingActionTitle, .cancelActionTitle],
                                      withActionStyles: [.default, .cancel],
                                      withPreferredStyle: .alert) { [weak self] (index) in
                                        guard index == 0 else {
                                            return
                                        }
                                        self?.openSettingsApp()
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            showAlertIfApplicationLocationAccessIsOff()
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        manager.stopMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
            reverseGeocode(location: location)
        }
    }
    
}
