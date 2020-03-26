//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Rohit Singh on 26/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

class DateUtility {

    func getFormattedDate(string: String , formatter: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
    
    func getFormattedDateForProductSearch() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return dateFormatterGet.string(from: Date())
    }
    
    func getCurrentDeviceDateAndTime() -> (date: String, isRefund: Bool) {
        // get the current date and time
        let currentDateTime = Date()
        
        // get the user's calendar
        let userCalendar = Calendar.current
                
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        // get the components
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        /*
         // now the components are available
         dateTimeComponents.year   // 2016
         dateTimeComponents.month  // 10
         dateTimeComponents.day    // 8
         dateTimeComponents.hour   // 22
         dateTimeComponents.minute // 42
         dateTimeComponents.second // 17
         */
        
        let twoDigitMonth = String(format: "%2d", (dateTimeComponents.month ?? 00))
        let twoDigitDay = String(format: "%02d", (dateTimeComponents.day ?? 00))

        return ("\(twoDigitMonth)-\(twoDigitDay)-\(dateTimeComponents.year ?? 0000)",
            ((dateTimeComponents.hour ?? 0) > 22) && ((dateTimeComponents.minute ?? 0) > 0))
        
    }
}

extension Date {
    
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func getDateAsString() -> String? {
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        return df.string(from: self)
    }
    
    func getDateOrderDate() -> String? {
        let df = DateFormatter()
        df.dateFormat = "MM-dd-yyyy"
        return df.string(from: self)
    }
    
  
}
