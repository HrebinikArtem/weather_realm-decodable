//
//  Router.swift
//  alamofireTest
//
//  Created by Artem Grebinik on 27.03.2018.
//  Copyright © 2018 Artem Hrebinik. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

enum Router: URLRequestConvertible {
    
    case getWeather(location: CLLocationCoordinate2D)
    
    private var basePath: String {
        return "https://api.darksky.net/forecast/"
    }
    
    private var apiKeyPath: String {
        return "b2883bcdaf7518cf7be38f42f56c6be5/"
    }
    
    private var path: String {
        switch self {
        case .getWeather(let location):
            return apiKeyPath + "\(location.latitude),\(location.longitude)"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    private var parametets: Parameters {
        switch self {
        case .getWeather(_):
            return ["lang":"ru", "units":"si"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try basePath.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        return try URLEncoding.default.encode(urlRequest, with: parametets)
    }
}
