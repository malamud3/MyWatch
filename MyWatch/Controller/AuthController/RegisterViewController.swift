////
////  RegisterViewController.swift
////  MyWatch
////
////  Created by Amir Malamud on 01/04/2023.
////
//
//import UIKit
//import FirebaseCore
//
//
//class RegisterViewController: UIViewController {
//
//    private let phoneTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Phone Number"
//        textField.keyboardType = .phonePad
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Password"
//        textField.isSecureTextEntry = true
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let registerButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Register", for: .normal)
//        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private let appleButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Register with Apple", for: .normal)
//        button.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private let googleButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Register with Google", for: .normal)
//        button.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
//        return button
//    }()
//
//    private var viewModel: RegisterViewModel!
//
//    init(authManager: AuthManager) {
//        super.init(nibName: nil, bundle: nil)
//        self.viewModel = RegisterViewModel(authManager: authManager)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(phoneTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(registerButton)
//
//        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        registerButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            phoneTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//
//        @objc private func registerButtonTapped() {
//            guard let phoneNumber = phoneTextField.text,
//                  let password = passwordTextField.text else {
//                return
//            }
//
//            viewModel.register(withPhoneNumber: phoneNumber, password: password) { success, error in
//                if let error = error {
//                    print("Registration failed: \(error.localizedDescription)")
//                } else if success {
//                    print("Registration successful!")
//                    // Navigate to next screen
//                }
//            }
//        }
//    }
//
