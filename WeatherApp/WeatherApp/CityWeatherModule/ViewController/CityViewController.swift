//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

class CityViewController: AppBaseViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var cityNamesTextView: UITextView!
    @IBOutlet weak var fetchCitiesInfoButton: UIButton!
    @IBOutlet weak var titleLableOfEntryInfo: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableViewCitiesInfo: UITableView!
    
    //MARK: Variables
    let placeholder = "Please enter city names separated by comma"
    
    fileprivate struct Constants {
        static let textViewBorderWidth = 1.0
        static let textViewCornerRadius = 4.0
    }
    
    //MARK: ViewModel
    let cityViewModel = CityViewModel()
    var apiCallIncrement = 0
    typealias Action = (Bool, Int) -> (Void)
    var completionAction: Action?
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        congigureUI()
    }
    
    //MARK: Private Methods
    fileprivate func setupView() {
        navigationItem.title = "Cities Weather"
        tableViewCitiesInfo.tableFooterView = UIView(frame: CGRect.zero)
        cityNamesTextView.delegate = self
        cityNamesTextView.text = placeholder
        cityNamesTextView.textColor = UIColor.lightGray
        cityNamesTextView.selectedTextRange = cityNamesTextView.textRange(from: cityNamesTextView.beginningOfDocument, to: cityNamesTextView.beginningOfDocument)
    }
    
    fileprivate func congigureUI() {
        cityNamesTextView.layer.borderColor = UIColor.lightGray.cgColor
        cityNamesTextView.layer.borderWidth = CGFloat(Constants.textViewBorderWidth)
        cityNamesTextView.layer.cornerRadius = CGFloat(Constants.textViewCornerRadius)
        fetchCitiesInfoButton.layer.cornerRadius = CGFloat(Constants.textViewCornerRadius)
    }
    
    //MARK: IBActions
    @IBAction func tapFetchCitiesInfoButton(_ sender: UIButton) {
        self.view.endEditing(true)
        print(cityViewModel.extractCityNames())
        if !cityViewModel.validateInput().0 {
            errorLabel.text = cityViewModel.validateInput().1
            errorLabel.textColor = cityViewModel.validateInput().2
        } else {
            
            showNoInternetConnectionAlert { [weak self] in
                self?.cityViewModel.resetDataSource()
                self?.tableViewCitiesInfo.reloadData()
                return
            }
            cityViewModel.resetDataSource()
            AppLoader().showProgress(status: nil, blockUI: true)
            shouldFetchNextCountryInfo()
        }
    }
    
    fileprivate func shouldFetchNextCountryInfo() {
        let cityName = cityViewModel.extractCityNames()[apiCallIncrement]
        cityViewModel.fetchWeather(for: cityName) { [weak self] (response) -> (Void) in
            self?.apiCallIncrement += 1
            DispatchQueue.main.async {
                self?.tableViewCitiesInfo.reloadData()
                if (self?.apiCallIncrement ?? 0) <= ((self?.cityViewModel.extractCityNames().count ?? 0) - 1) {
                    self?.shouldFetchNextCountryInfo()
                } else {
                    AppLoader().hideProgress()
                    self?.apiCallIncrement = 0
                }
            }
            
        }
    }
    
}
