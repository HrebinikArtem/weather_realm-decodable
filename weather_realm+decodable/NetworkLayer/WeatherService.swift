//
//  WeatherService.swift
//  alamofireTest
//
//  Created by Artem Grebinik on 27.03.2018.
//  Copyright © 2018 Artem Hrebinik. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class WeatherService {
    
    typealias DownloadWeatherForecastCompletion = (Wel) -> Void
    typealias ParseWeatherForecastCompletion = (Wel) -> Void

    func getWeatherForecast(for location: String, completion: @escaping DownloadWeatherForecastCompletion) {
        
        CLGeocoder().geocodeAddressString(location) { [weak self] (placemarks, error) in
            
            guard error == nil else { return }
            guard let location = placemarks?.first?.location else { return }
            
            Alamofire.request(Router.getWeather(location: location.coordinate)).responseData(completionHandler: { [weak self] (response) in
                
                switch response.result {
                    
                case .success(let responseData):

                    self?.parseWeather(from: responseData, completion: { (welcom) in
                        completion(welcom)
                    })
                    
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    private func parseWeather(from data: Data, completion: @escaping ParseWeatherForecastCompletion) {
        
        let decoder = JSONDecoder()
    
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let weather = try decoder.decode(Wel.self, from: data)
//            dump(weather)
            completion(weather)
       
        } catch {
            print(error)
        }
    }
}



