//  WeatherApp
//
//  Created by Rohit Singh on 25/03/2020.
//  Copyright © 2020 SMD. All rights reserved.
//
import UIKit

// MARK: - Definitions -
let applicationId = "IOS"

enum AppApiTimeinterval {
    case sixty
    case ninty
    
    var value: TimeInterval {
        switch self {
        case .sixty: return TimeInterval(60)
        case .ninty: return TimeInterval(90)
        }
    }
}

enum AppHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum SubPathType: String {
    case comingSoon
    case oAuth
    
    var value: String {
        switch self {
        case .comingSoon: return "coming-soon"
        case .oAuth: return "oauth"
        }
    }
    
}

// MARK: - Type -
protocol Buildable {
    var endPoint: String { get }
    var methodType: AppHTTPMethod { get }
    var headers: [String: String] { get }
    var requestBody: [String: Any]? { get }
    var subPath: SubPathType { get }
    
    var url: URL? { get }
    func build() -> URLRequest?
}

extension Buildable {
    
    private var path: String {
        return [AppEnvironment.baseURL, subPath.value, endPoint].joined(separator: "/")
    }

    var methodType: AppHTTPMethod {
        return .get
    }
    
    var headers: [String: String] {

        var headers: [String: String] = [:]
    
        headers["appId"]        = applicationId
        headers["Token"]   = "token"
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
    
    var url: URL? {
        guard let url = URL(string: path) else {
            return nil
        }
        return url
    }
    
    func build() -> URLRequest? {
        guard let url = url else {
            return nil
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: AppApiTimeinterval.sixty.value)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = methodType.rawValue
        if let params = requestBody {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let exception {
                // Error Handling
                print(exception.localizedDescription)
                return nil
            }
        }
        
        return urlRequest
    }
}
