//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Vincent Bossaerts on 24/03/18.
//  Copyright © 2018 Vincent Bossaerts. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherTableViewController: UITableViewController {

    var city: String?
    var isLocationNeeded: Bool?
    
    var day: WheaterDay?
    
    var didLoad = false
    
    let wheaterUrlOneDay = "http://api.openweathermap.org/data/2.5/weather"
    //request= wheaterURL + ?q=London
    //request= whaterURL+ ?lat=35&long=139
    let apiKey = "97c1792c121b7fe9ccdd8c4e44b4e341"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLocationNeeded == true {
            //get the location from gps
        } //call func to get weather
        else {
            getJSONfromCity(city: city!)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if didLoad == false {
            return 0}
        else {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        
        cell.weatherRain.text = day?.precipatazioni //reorder
        cell.weatherTempMax.text = day?.temperatureMax
        cell.weatherTempMin.text = day?.temperatureMin
        cell.weatherTime.text = String(describing: Date.init())
        cell.weatherWindSpeed.text = day?.windSpeed
        print("loading")
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    func getJSONfromLocation(lat: String, long: String) {
        let params: [String: String] = ["lat": lat, "long": long, "appid": apiKey]
        getJSON(url: wheaterUrlOneDay, params: params)
    }
    
    func getJSONfromCity(city: String) {
        let params: [String: String] = ["q": city, "appid": apiKey]
        getJSON(url: wheaterUrlOneDay, params: params)
        
    }
    func getJSON(url: String, params: [String: String]) {
 
        Alamofire.request(url, method: .get, parameters: params).responseJSON {response in
            if response.result.isSuccess {
                let wheaterJSON: JSON = JSON(response.result.value!)
                self.getData(json: wheaterJSON)
            } else {
                print(response.error!)
            }
        }
    }
    func getData(json: JSON) {
        print(json)
        print("setting values")
        let temperatureMax = String(json["main"]["temp_max"].floatValue)
        let temperatureMin = String(json["main"]["temp_min"].floatValue)
        let windSpeed = String(json["wind"]["speed"].floatValue)
        let precipazioni = json["weather"][0]["main"].stringValue
        day = WheaterDay(temperatureMin: temperatureMin, temperatureMax: temperatureMax, windSpeed: windSpeed, precipatazioni: precipazioni)
        didLoad = true
        self.tableView.reloadData()
    }
    /*
     example
     {"coord":{"lon":-122.09,"lat":37.39},
     "sys":{"type":3,"id":168940,"message":0.0297,"country":"US","sunrise":1427723751,"sunset":1427768967},
     "weather":[{"id":800,"main":"Clear","description":"Sky is Clear","icon":"01n"}],
     "base":"stations",
     "main":{"temp":285.68,"humidity":74,"pressure":1016.8,"temp_min":284.82,"temp_max":286.48},
     "wind":{"speed":0.96,"deg":285.001},
     "clouds":{"all":0},
     "dt":1427700245,
     "id":0,
     "name":"Mountain View",
     "cod":200}
     */
}
