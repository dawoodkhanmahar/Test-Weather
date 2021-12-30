//
//  ViewController.swift
//  TestWeather
//
//  Created by MacBook Pro on 29/12/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var city: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchField.delegate = self
    }

    @IBAction func searchPressed(_ sender: Any) {
        
        searchField.endEditing(true)
    }
    
}
extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchField.text = ""
    }
    
    
}

extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temp.text = weather.temperatureString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.city.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: CLLocationManagerDelegate{
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
