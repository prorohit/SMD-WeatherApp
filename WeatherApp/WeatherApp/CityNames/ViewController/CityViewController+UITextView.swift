//
//  CityViewController+UITextView.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import UIKit

extension CityViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        // Saving the updated text entered by user in the viewmodel variable
        cityViewModel.saveEnteredText(updatedText.replacingOccurrences(of: placeholder, with: ""))
        
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            return false
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        errorLabel.text = cityViewModel.validateInput().1
        errorLabel.textColor = cityViewModel.validateInput().2
        return cityViewModel.canEnterMoreCities()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
}

