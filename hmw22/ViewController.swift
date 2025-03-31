//
//  ViewController.swift
//  hmw22
//
//  Created by Артём Горовой on 11.01.25.
//

import UIKit
import WebKit
import SnapKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private let textField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите запрос или URl"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        return textField
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("◀︎", for: .normal)
        return button
    }()
    private let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶︎", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupWebView()
    }
    
    private func setUI() {
        view.addSubview(textField)
        view.addSubview(backButton)
        view.addSubview(forwardButton)
        textField.delegate = self
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(40)
        }
    
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(50)
        }
        forwardButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(50)
        }
    }
    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)
        

        webView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        let firstAction = UIAction { _ in
            self.tapBackButton()
        }
        let secondAction = UIAction { _ in
            self.tapForwardButton()
        }
        backButton.addAction(firstAction, for:.touchUpInside)
        forwardButton.addAction(secondAction, for:.touchUpInside)
        
    }
    private func tapBackButton () {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    private func tapForwardButton () {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        let urlString = "https://www.google.com/search?q=\(text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            return false
        }
        webView.load(URLRequest(url: url))
        textField.resignFirstResponder()
        return true
    }
}
