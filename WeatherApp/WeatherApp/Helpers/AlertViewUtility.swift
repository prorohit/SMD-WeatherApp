//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

class AlertViewUtility: UIAlertController {
    /**
     Global closure which returns the callback with index of the button clicked
     */
    var userIdTextField: UITextField?
    var callBackOnActionButtonClicked: ((Int) -> Void)?
    var callBackActionTextFieldButtonClicked: ((Int, String?) -> Void)?
    
    convenience init(withGenericMode alertTitle: String?,
                     withMessage alertMessage: String?,
                     withActionTitles: [String],
                     withActionStyles: [UIAlertAction.Style],
                     withPreferredStyle alertPreferredStyle: UIAlertController.Style,
                     completionHandler: ((Int) -> Void)?) {
      
        
        self.init(title: alertTitle, message: alertMessage, preferredStyle: alertPreferredStyle)
        if alertPreferredStyle == .actionSheet,
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            self.popoverPresentationController?.sourceView = self.view
            self.popoverPresentationController?.sourceRect = CGRect(x: window.bounds.midX, y: window.bounds.midY, width: 0, height: 0)
            self.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        }
        let zip_title_type = zip(withActionTitles, withActionStyles)
       
        
        for (i, pair) in zip_title_type.enumerated() {
            let action = UIAlertAction(title: pair.0, style: pair.1) { (_) in
                DispatchQueue.main.async {
                    if let callBackOnActionButtonClicked =  self.callBackOnActionButtonClicked {
                        callBackOnActionButtonClicked(i)
                    }
                }
              
            }
            addAction(action)
        }
        callBackOnActionButtonClicked = completionHandler
    }
    
}
