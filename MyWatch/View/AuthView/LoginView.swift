//
//  LoginView.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//
import UIKit

class LoginView: UIView {
    // MARK: - UI Elements
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple_icon"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "google_icon"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Properties
    
    var loginButtonAction: ((String) -> Void)?
    var appleButtonAction: (() -> Void)?
    var googleButtonAction: (() -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(phoneNumberTextField)
        addSubview(loginButton)
        addSubview(appleButton)
        addSubview(googleButton)
        
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            appleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            appleButton.widthAnchor.constraint(equalToConstant: 44),
            appleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            googleButton.leadingAnchor.constraint(equalTo: appleButton.trailingAnchor, constant: 16),
            googleButton.widthAnchor.constraint(equalToConstant: 44),
            googleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
    }
    
    @objc private func didTapLoginButton() {
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            return
        }
        
        let alert = UIAlertController(title: "Login", message: "Choose your login provider", preferredStyle: .actionSheet)
        
        let appleAction = UIAlertAction(title: "Apple", style: .default) { [weak self] _ in
            self?.loginButtonAction?("Apple: " + phoneNumber)
        }
        alert.addAction(appleAction)
        
        let googleAction = UIAlertAction(title: "Google", style: .default) { [weak self] _ in
            self?.loginButtonAction?("Google: " + phoneNumber)
        }
        alert.addAction(googleAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if let viewController = self.parentViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
        
    }
}
