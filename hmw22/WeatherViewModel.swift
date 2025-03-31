//
//  WeatherViewModel.swift
//  hmw22
//
//  Created by Артём Горовой on 31.03.25.
//
import Foundation
import Foundation

class WeatherViewModel {
    private let apiKey = "da9d5a768083fa4eb48199923346d0c8"

    // MARK: - Fetch Weather Data
    func fetchWeather(for city: String, completion: @escaping (WeatherModel?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=metric&lang=ru"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}


