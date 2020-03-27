//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityNameButton: UIButton!
    @IBOutlet weak var gpsCityNameButton: UIButton!
    
    fileprivate struct Constants {
        static let textViewCornerRadius = 4.0
    }
    
    // Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        weatherImageView.layer.cornerRadius = CGFloat(Constants.textViewCornerRadius)
        cityNameButton.layer.cornerRadius = CGFloat(Constants.textViewCornerRadius)
        gpsCityNameButton.layer.cornerRadius = CGFloat(Constants.textViewCornerRadius)

    }
}

