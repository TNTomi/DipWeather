//
//  WeatherModel.swift
//  hmw22
//
//  Created by Артём Горовой on 11.01.25
//
import Foundation

struct WeatherModel: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

