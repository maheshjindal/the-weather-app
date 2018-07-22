//
//  TheWeatherAPI.swift
//  TheWeatherApp
//
//  Created by Mahesh Jindal on 14/07/18.
//  Copyright © 2018 Mahesh Jindal. All rights reserved.
//

import Foundation
import UIKit


func BuildURL(_ lat:Float, _ lon:Float) -> URL {
    
    let basic_url = URL(string: "http://api.openweathermap.org/data/2.5/weather")
    let info : [String:String] = [
        "appid": "107d1bf8462613f3fe8525cc8b32b1f3",
        "lat": String(lat),
        "lon": String(lon)
    ]
    return (basic_url?.withQueries(info))!
}

func parseResult(data:[String:AnyObject]) -> [String:Float] {
    print(data)
    var weatherData = [String:Float]()
    
    guard let cod = data["cod"] else {
        return weatherData
    }
    guard let data = data["main"] as? [String:AnyObject] else{
        return weatherData
    }
    guard let current_temp = data["temp"]  else{
        return weatherData
    }
    guard let pressure = data["pressure"] else{
        return weatherData
    }
    weatherData["cod"] = Float(truncating: cod as! NSNumber)
    weatherData["temp"] = (current_temp.floatValue.rounded() - 273.0)
    weatherData["pressure"] = pressure.floatValue.rounded()
    
    return weatherData
}
