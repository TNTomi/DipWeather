//
//  CitySellectionViewController.swift
//  hmw22
//
//  Created by Артём Горовой on 02.02.25.
//
import UIKit
import SnapKit

class CitySelectionViewController: UIViewController {
    
    // MARK: - Properties
    private let weatherViewModel = WeatherViewModel()
    private let cityTextField = UITextField()
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#003333")
        
        cityTextField.placeholder = "Введите город"
        cityTextField.borderStyle = .roundedRect
        cityTextField.backgroundColor = .white
        cityTextField.textAlignment = .center
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityTextField)
        
        searchButton.setTitle("Узнать погоду", for: .normal)
        searchButton.backgroundColor = .white
        searchButton.setTitleColor(.systemBlue, for: .normal)
        searchButton.layer.cornerRadius = 10
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        
        cityTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(-50)
            make.width.equalTo(250)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(cityTextField.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(180)
            make.height.equalTo(40)
        }
        
        let action = UIAction { _ in
            self.fetchWeather()
        }
        searchButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Fetch Weather
    private func fetchWeather() {
        guard let city = cityTextField.text, !city.isEmpty else { return }
        cityTextField.resignFirstResponder()
        
        weatherViewModel.fetchWeather(for: city) { [weak self] weather in
            DispatchQueue.main.async {
                if let weather = weather {
                    let weatherVC = WeatherViewController(weather: weather)
                    self?.navigationController?.pushViewController(weatherVC, animated: true)
                } else {
                    let alert = UIAlertController(title: "Ошибка", message: "Город не найден", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
