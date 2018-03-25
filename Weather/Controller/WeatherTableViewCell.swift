//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Vincent Bossaerts on 25/03/18.
//  Copyright © 2018 Vincent Bossaerts. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var weatherTime: UILabel!
    
    @IBOutlet weak var weatherTempMax: UILabel!
    
    @IBOutlet weak var weatherTempMin: UILabel!
    
    @IBOutlet weak var weatherWindSpeed: UILabel!
    
    @IBOutlet weak var weatherRain: UILabel!
    
}
