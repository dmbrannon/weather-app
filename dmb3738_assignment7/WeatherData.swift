//
//  WeatherData.swift
//  dmb3738_assignment7
//
//  Created by Dana Brannon on 11/3/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherDataProtocol
{
    func responseDataHandler(data:NSDictionary)
    func responseError(message:String)
}

class WeatherData {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=1f724bf3cdc54b53b4b223419190311&format=json&q="
    
    private var dataTask:URLSessionDataTask? = nil
    
    var delegate:WeatherDataProtocol? = nil
    
    init() {}
    
    func getData(cityAndState:String) {
        var urlPath = self.urlPathBase
        urlPath = urlPath + cityAndState // ex: fort+worth,texas
        
        let url:NSURL? = NSURL(string: urlPath)
        
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if jsonResult != nil {
                        
                        let data = jsonResult!["data"]! as? NSDictionary
                        
                        // CHECK JSON DATA FOR ERROR MESSAGE (use responseError)
                        let error = data!["error"] as? NSArray
                        if error != nil {
                            let errormsg = error![0] as? NSDictionary
                            self.delegate?.responseError(message: errormsg!["msg"]! as! String)
                        }
                        
                        // IF NO ERROR, EXTRACT DATA
                        else {
                            
                            let current = data!["current_condition"] as? NSArray
                            if current != nil {
                                self.delegate?.responseDataHandler(data: jsonResult!)
                            }
                        }
                    }
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        dataTask.resume()
    }
}
