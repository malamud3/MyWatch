//
//  RegisterViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 03/02/2023.
//
import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa


class RegisterViewController: UIViewController {
    
    private var viewModel = RegisterViewModel()
    private let disposeBag = DisposeBag()

    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = S.placeHolder.Email
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = S.placeHolder.Password
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(S.title.Register, for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
           super.viewDidLoad()
           
           setupUI()
           bindViewModel()
           bindUI()
       }
    
    private func setupUI() {
            view.addSubview(emailTextField)
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            ])
            
            view.addSubview(passwordTextField)
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
                passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
            ])
            
            view.addSubview(registerButton)
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
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
    
    private func bindViewModel() {
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .bind(to: viewModel.registerTapped)
            .disposed(by: disposeBag)
        
        viewModel.registerSuccess
            .subscribe(onNext: { [weak self] success in
                if success {
                    self?.goToHome()
                } else {
                    // Show error
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
    }
        
            private func goToHome() {
                let homeVC = HomeViewController()
                navigationController?.pushViewController(homeVC, animated: true)
            }
        }
    





