//
//  ViewController.swift
//  dmb3738_assignment7
//
//  Created by Dana Brannon on 11/3/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherDataProtocol {
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var checkConditions: UIButton!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var CLOUDCOVER: UILabel!
    @IBOutlet weak var HUMIDITY: UILabel!
    @IBOutlet weak var PRESSURE: UILabel!
    @IBOutlet weak var PRECIPITATION: UILabel!
    @IBOutlet weak var WIND: UILabel!
    
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var NOTFOUND: UILabel!
    
    var dataSession = WeatherData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSession.delegate = self
        
        // Hide data labels initially
        weatherImage.isHidden = true
        temperatureLabel.isHidden = true
        
        CLOUDCOVER.isHidden = true
        HUMIDITY.isHidden = true
        PRESSURE.isHidden = true
        PRECIPITATION.isHidden = true
        WIND.isHidden = true
        
        cloudLabel.isHidden = true
        humidityLabel.isHidden = true
        pressureLabel.isHidden = true
        precipitationLabel.isHidden = true
        windLabel.isHidden = true
        
        NOTFOUND.isHidden = true
    }

    // MARK: Actions
    @IBAction func buttonClicked(_ sender: Any) {
        let entryString = String(cityField.text!) + "," + String(stateField.text!)
        let entry = entryString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        if ((cityField.text != "")||(stateField.text != "")) {
            self.dataSession.getData(cityAndState: String(entry))
        
            // Unhide data labels
            weatherImage.isHidden = false
            temperatureLabel.isHidden = false
            
            CLOUDCOVER.isHidden = false
            HUMIDITY.isHidden = false
            PRESSURE.isHidden = false
            PRECIPITATION.isHidden = false
            WIND.isHidden = false
            
            cloudLabel.isHidden = false
            humidityLabel.isHidden = false
            pressureLabel.isHidden = false
            precipitationLabel.isHidden = false
            windLabel.isHidden = false
        }
    }
    
    //MARK: Weather Data Protocol
    
    func responseDataHandler(data:NSDictionary) {
        let data = data["data"]! as? NSDictionary
        let current = data!["current_condition"] as? NSArray
        
        let conditions = current![0] as? NSDictionary
        //print(conditions)
        
        let tempF = conditions!["temp_F"] as? String
        let tempC = conditions!["temp_C"] as? String
        let cloudCover = conditions!["cloudcover"] as? String
        let humidity = conditions!["humidity"] as? String
        let pressure = conditions!["pressure"] as? String
        let precipitation = conditions!["precipMM"] as? String
        let windKMPH = conditions!["windspeedKmph"] as? String
        let windMPH = conditions!["windspeedMiles"] as? String
        let windDirection = conditions!["winddir16Point"] as? String
        let windDegrees = conditions!["winddirDegree"] as? String
        
        // Get image from URL
        let test1 = conditions!["weatherIconUrl"] as? NSArray
        let test2 = test1![0] as? NSDictionary
        let urlString = test2!["value"] as? String
        let url = URL(string: urlString!)!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.weatherImage.image = UIImage(data: data!)
            }
        }
        
        //Run this handling on a separate thread
        DispatchQueue.main.async() {
            self.temperatureLabel.text = tempC! + "°C/" + tempF! + "°F"
            
            self.cloudLabel.text = cloudCover! + "%"
            
            self.humidityLabel.text = humidity! + "%"
            
            self.pressureLabel.text = pressure! + "mbar"
            
            self.precipitationLabel.text = precipitation! + "mm"
            
            self.windLabel.text = windKMPH! + "kmph/" + windMPH! + "mph " + windDirection! + " (" + windDegrees! + "°)"
            
            self.NOTFOUND.isHidden = true
        }
    }
    
    func responseError(message:String) {
        //Run this handling on a separate thread
        DispatchQueue.main.async() {
            self.NOTFOUND.isHidden = false
            
            self.weatherImage.isHidden = true
            self.temperatureLabel.isHidden = true
            
            self.CLOUDCOVER.isHidden = true
            self.HUMIDITY.isHidden = true
            self.PRESSURE.isHidden = true
            self.PRECIPITATION.isHidden = true
            self.WIND.isHidden = true
            
            self.cloudLabel.isHidden = true
            self.humidityLabel.isHidden = true
            self.pressureLabel.isHidden = true
            self.precipitationLabel.isHidden = true
            self.windLabel.isHidden = true
        }
    }
    
}

