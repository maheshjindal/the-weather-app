//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by Mahesh Jindal on 10/07/18.
//  Copyright © 2018 Mahesh Jindal. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var pres: UILabel!
    
    let locationManager = CLLocationManager()
    var longitude:Double!
    var latitude:Double!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    func getData(_ lat:Float, _ lon:Float){
        let url = BuildURL(lat, lon)
        print(url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if(error != nil){
                
            }else{
                if let data = data{
                    let parsedResult : [String:AnyObject]!
                    do{
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject]
                        
                    }catch{
                        print("Unable to parse")
                        return
                    }
                    let result = parseResult(data: parsedResult)
                    if result["cod"] != 200  {
                        return
                    }
                    print(result)
                    DispatchQueue.main.async {
                        self.temp.text = String(result["temp"]!)
                        self.pres.text = String(result["pressure"]!)
                    }
                    
                    
                }
            }
            
        })
        task.resume()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
        }
        
        let longitude = Float(location.coordinate.longitude)
        let latitude = Float(location.coordinate.latitude)
        print(longitude,latitude)
        getData(latitude, longitude)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

