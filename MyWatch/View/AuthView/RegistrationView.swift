//
//  RegistrationView.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//

import UIKit

class RegistrationView: UIView {

    // MARK: - Properties

    let viewModel: RegistrationViewModel
    
    lazy var backgroundImageView: UIImageView = {
         let imageView = UIImageView(image: UIImage(named: "Screen_Register"))
        imageView.contentMode = .center
         return imageView
     }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Verify", for: .normal)
        button.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
        return button
    }()
    
    lazy var verificationCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Verification Code"
        textField.isHidden = true
        textField.keyboardType = .numberPad
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: S.picName.Icon_apple), for: .normal)
        button.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        return button
    }()

    lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: S.picName.Icon_google), for: .normal)
        button.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        return button
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondarySystemBackground
        view.layer.cornerRadius = 90
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    // MARK: - Initialization

    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews

    private func configureSubviews() {
        
        addSubview(backgroundImageView)
         sendSubviewToBack(backgroundImageView)
        
         addSubview(cardView)
         cardView.addSubview(phoneTextField)
         cardView.addSubview(verifyButton)
         cardView.addSubview(verificationCodeTextField)
         cardView.addSubview(registerButton)
         cardView.addSubview(appleButton)
         cardView.addSubview(googleButton)
        
    }
    
    private func configureConstraints() {
        // backgroundImageView
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        // phoneTextField
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            phoneTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50),
            phoneTextField.widthAnchor.constraint(equalToConstant: 200),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // verifyButton
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verifyButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            verifyButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            verifyButton.widthAnchor.constraint(equalToConstant: 100),
            verifyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // verificationCodeTextField
        verificationCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verificationCodeTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            verificationCodeTextField.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 20),
            verificationCodeTextField.widthAnchor.constraint(equalToConstant: 200),
            verificationCodeTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // registerButton
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: verificationCodeTextField.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: 100),
            registerButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        // appleButton
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            appleButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            appleButton.widthAnchor.constraint(equalToConstant: 150),
            appleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // googleButton
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            googleButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            googleButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            googleButton.widthAnchor.constraint(equalTo: appleButton.widthAnchor),
            googleButton.heightAnchor.constraint(equalTo: appleButton.heightAnchor)
        ])
        // cardView
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.widthAnchor.constraint(equalTo: widthAnchor,constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 400),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: -20)
        ])

        
    }

    // MARK: - Actions
    
    @objc private func didTapVerifyButton() {
        guard let phoneNumber = phoneTextField.text else {
            return
        }
        viewModel.model.phoneNumber = phoneNumber
        viewModel.register(with: .phone) { success, error in
            if let error = error {
                // Display error message
                print(error)
            } else if success {
                // Hide phone text field and verify button
                self.phoneTextField.isHidden = true
                self.verifyButton.isHidden = true
                
                // Show verification code text field and register button
                self.verificationCodeTextField.isHidden = false
                self.registerButton.isHidden = false
            }
        }
    }
    
    @objc private func didTapRegisterButton() {
        guard let verificationCode = verificationCodeTextField.text else {
            return
        }
        viewModel.model.verificationCode = verificationCode
        viewModel.register(with: .phone) { success,error  in
            if success {
                // Display success message and clear text fields
                print("Registration successful!")
                self.phoneTextField.text = ""
                self.verificationCodeTextField.text = ""
                
                // Hide verification code text field and register button
                self.verificationCodeTextField.isHidden = true
                self.registerButton.isHidden = true
                
                // Show phone text field and verify button
                self.phoneTextField.isHidden = false
                self.verifyButton.isHidden = false
            } else {
                // Display error message and clear verification code text field
                print("Registration failed")
                self.verificationCodeTextField.text = ""
            }
        }
    }
    @objc private func didTapAppleButton() {
        viewModel.register(with: .apple) { success, error in
            if let error = error {
                // Display error message
                print(error)
            } else if success {
                // Do something
            }
        }
    }

    @objc private func didTapGoogleButton() {
        viewModel.register(with: .google) { success, error in
            if let error = error {
                // Display error message
                print(error)
            } else if success {
                // Do something
            }
        }
    }
}


