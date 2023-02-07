//
//  LoginViewController.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 02/02/2023.
//
import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa


class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    
    private let emailTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Email"
           textField.autocapitalizationType = .none
           textField.autocorrectionType = .no
           textField.keyboardType = .emailAddress
           textField.backgroundColor = .secondarySystemBackground
           textField.layer.cornerRadius = 12
           textField.layer.borderWidth = 1
           textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
           textField.translatesAutoresizingMaskIntoConstraints = false

           return textField
       }()
    
    private let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.backgroundColor = .secondarySystemBackground
            textField.layer.cornerRadius = 12
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.secondaryLabel.cgColor
            textField.translatesAutoresizingMaskIntoConstraints = false

            return textField
        }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
        bindUI()
    }
    
    private func setupUI() {
        
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        registerButton.setTitle(S.title.Register, for: .normal)
        
        
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        registerButton.setTitle(S.title.Register, for: .normal)
        
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])

    }
    private func bindViewModel(){
        
        emailTextField.rx.text.orEmpty
             .bind(to: viewModel.email)
             .disposed(by: disposeBag)
           
           passwordTextField.rx.text.orEmpty
             .bind(to: viewModel.password)
             .disposed(by: disposeBag)
           
        
           viewModel.isLoginEnabled
             .bind(to: activityIndicator.rx.isAnimating)
             .disposed(by: disposeBag)
           
        
        loginButton.rx.tap
            .bind(to: viewModel.loginTapped)
            .disposed(by: disposeBag)
        
        viewModel.loginSuccess
            .subscribe(onNext: { [weak self] success in
                if success {
                    self?.goToHome()
                } else {
                    print("loginSuccess: \(success)")
                }
            })
            .disposed(by: disposeBag)
    }
    private func bindUI() {
        
        registerButton.rx.tap
          .subscribe(onNext: { [weak self] in
            self?.view.endEditing(true)
          })
        
          .disposed(by: disposeBag)
        
        registerButton.rx.tap
          .subscribe(onNext: { [weak self] in
            self?.view.endEditing(true)
            self?.goToRegister()
          })
          .disposed(by: disposeBag)
        
    }
    private func goToRegister() {
        let RegisterVC = RegisterViewController()
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    private func goToHome() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
                                       

