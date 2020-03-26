//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

class AppBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    func showNoInternetConnectionAlert(completion: @escaping () -> Void) {
        if !Reachability.isConnectedToNetwork() {
            let alert = AlertViewUtility(withGenericMode: "No Internet connection", withMessage: "Please connect to internet and try again", withActionTitles: ["OK"], withActionStyles: [.default], withPreferredStyle: .alert) { (_) in
                       completion()
                   }
                   self.present(alert, animated: true, completion: nil)
        }
    }
}
