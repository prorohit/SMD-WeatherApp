//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class AppLoader {
    
    func showProgress(status: String?, blockUI: Bool = true) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window else {
                return
        }
        SVProgressHUD().containerView = window
        if blockUI {
            SVProgressHUD.setDefaultMaskType(.clear)
        }
        SVProgressHUD.show(withStatus: status)
    }
    
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
}
