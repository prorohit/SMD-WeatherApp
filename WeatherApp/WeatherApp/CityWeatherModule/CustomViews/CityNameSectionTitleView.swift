//
//  ActivitySectionTitleView.swift
//  DSC-App
//
//  Created by Rohit Singh on 03/12/2019.
//  Copyright © 2019 Application. All rights reserved.
//

import UIKit

class CityNameSectionTitleView: UIView {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    func setUpSection(with title: String?) {
        sectionTitleLabel.text = title
    }
}
