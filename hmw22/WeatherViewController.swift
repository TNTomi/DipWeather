//
//  WeatherViewController.swift
//  hmw22
//
//  Created by Артём Горовой on 19.02.25.
//
import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private let weather: WeatherModel
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let emojiImageView = UIImageView()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = UIColor(hex: "#003333")
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - Initialization
    init(weather: WeatherModel) {
        self.weather = weather
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.hidesBackButton = true
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = getBackgroundColor(for: weather.main.temp)
        
        iconImageView.image = UIImage(named: getWeatherIcon(for: weather.weather.first?.icon ?? "01d"))
        iconImageView.contentMode = .scaleAspectFit
        view.addSubview(iconImageView)
        
        temperatureLabel.text = "\(Int(weather.main.temp))°C"
        temperatureLabel.font = UIFont.systemFont(ofSize: 60, weight: .light)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        view.addSubview(temperatureLabel)
        
        descriptionLabel.text = weather.weather.first?.description.capitalized ?? "Без данных"
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
        view.addSubview(descriptionLabel)
        
        emojiImageView.image = UIImage(named: getEmojiImage(for: weather.main.temp))
        emojiImageView.contentMode = .scaleAspectFit
        view.addSubview(emojiImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
            make.width.height.equalTo(100)
        }

        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        emojiImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(200)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(15)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }

        let action = UIAction { _ in
            self.goBack()
        }
        backButton.addAction(action, for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    private func getWeatherIcon(for code: String) -> String {
        switch code {
        case "01d": return "sun"
        case "02d", "03d", "04d": return "cloud"
        case "09d", "10d": return "rain"
        case "11d": return "storm"
        default: return "cloud"
        }
    }
    private func getBackgroundColor(for temp: Double) -> UIColor {
        switch temp {
        case ..<0: return UIColor(hex: "#ADD8E6") ?? .lightGray
        case 0..<15: return UIColor(hex: "#808080") ?? .gray
        case 15..<20: return UIColor(hex: "#FFD700") ?? .yellow
        default: return UIColor(hex: "#FF8C00") ?? .orange
        }
    }
    private func getEmojiImage(for temp: Double) -> String {
        switch temp {
        case ..<0: return "verycold"
        case 0..<15: return "cold"
        case 15..<20: return "norm"
        default: return "sun"
        }
    }
}

