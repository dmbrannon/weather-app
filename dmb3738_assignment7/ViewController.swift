//
//  ViewController.swift
//  dmb3738_assignment7
//
//  Created by Dana Brannon on 11/3/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func getData(_ sender: Any) {
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

