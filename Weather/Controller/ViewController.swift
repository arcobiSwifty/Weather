//
//  ViewController.swift
//  Weather
//
//  Created by Vincent Bossaerts on 24/03/18.
//  Copyright © 2018 Vincent Bossaerts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getWeatherPressed(_ sender: UIButton) {
        //performSegue(withIdentifier: "getWeatherFromCityName", sender: self)
    }
    
    @IBAction func useGpsPressed(_ sender: UIButton) {
        //performSegue(withIdentifier: "getWeatherFromLocation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "getWeatherFromCityName" {
            let destination = segue.destination as? WeatherTableViewController
            destination?.city = cityTextField.text!
            destination?.isLocationNeeded = false
        } else if segue.identifier == "getWeatherFromLocation" {
            let destination = segue.destination as? WeatherTableViewController
            destination?.isLocationNeeded = true
        } else if segue.identifier == "getOptions" {
            
        }
    }
    
}

