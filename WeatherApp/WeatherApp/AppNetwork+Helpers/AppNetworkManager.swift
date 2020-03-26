//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//

import Foundation

enum AppAPIError: Error {
    case buildableFailure
    case noData
    case noInternetConnection
    var value: String {
        switch self {
        case .buildableFailure: return "No able to form buildable"
        case .noData: return "No data returned from API"
        case .noInternetConnection: return "No internet connection"
        }
    }
}

class AppNetworkManager: Logger {
    
    var shouldLog: Bool {
        return true
    }
    
    func processAPI<T: Codable>(_ buildable: Buildable,
                                modelType: T.Type,
                                completionHandler: @escaping (AppAPIResult<T>) -> Void) {
        
        guard let urlRequest = buildable.build() else {
            completionHandler(.failure(AppAPIServiceError(message: AppAPIError.buildableFailure.value)))
            return
        }
        self.log(urlRequest)
        let session = URLSession.shared
        
        // Starting the session
        session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            let response = response as? HTTPURLResponse
            self.log(response, data: data)
            guard let data = data else {
                completionHandler(.failure(AppAPIServiceError(message: error?.localizedDescription ?? AppAPIError.noData.value)))
                return
            }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(model))
                
            } catch let e {
                completionHandler(.failure(AppAPIServiceError(message: e.localizedDescription)))
            }
            AppLogger().printRequestResponse(request: urlRequest, data: data)
        }).resume()
    }
    
}

enum AppAPIResult<T: Codable> {
    case success(T)
    case failure(AppAPIServiceError?)
}

struct AppAPIServiceError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

