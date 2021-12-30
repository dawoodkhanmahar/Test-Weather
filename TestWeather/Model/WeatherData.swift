//
//  WeatherData.swift
//  TestWeather
//
//  Created by MacBook Pro on 29/12/2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
