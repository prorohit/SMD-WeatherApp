//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//
import Foundation

class AppLogger {
    
    class func logInput(_ message: Any?) {
        guard AppConfigs.shared.shouldPrintLogs else {
                return
        }
        print(message ?? "No message")
    }
    
    func printRequestResponse(request: URLRequest, data: Data) {
        
        guard AppConfigs.shared.shouldPrintLogs else {
                return
        }
        
        print("======================= Request Starts =======================")
        if let urlAsString = request.url?.absoluteURL {
            print("URL: \(urlAsString)")
        }
        
        if let method = request.httpMethod {
            print("\nMethod: \(method)")
        }
        
        if let headerParams = request.allHTTPHeaderFields {
            print("\nHeader Params: ")
            print(headerParams)
        }
        if let dataParams = request.httpBody {
            print("\n HTTP Body: ")
            if let jsonBodyString = String(bytes: dataParams, encoding: .ascii) {
                print(jsonBodyString)
            }
        }
        print("====================== Request Ends =========================")
        print("====================== Response Starts ======================")
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let jsonString = String(bytes: prettyPrintedData, encoding: .ascii) {
            print(jsonString)
        }
        print("================== Response Ends ===========================")
    }
}
