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
    
    let phoneTextField = UITextField()
    let verifyButton = UIButton()
    let verificationCodeTextField = UITextField()
    let registerButton = UIButton()
    
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
        phoneTextField.placeholder = "Phone Number"
        phoneTextField.keyboardType = .phonePad
        
        verifyButton.setTitle("Verify", for: .normal)
        verifyButton.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
        
        verificationCodeTextField.placeholder = "Verification Code"
        verificationCodeTextField.isHidden = true
        verificationCodeTextField.keyboardType = .numberPad
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.isHidden = true
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        addSubview(phoneTextField)
        addSubview(verifyButton)
        addSubview(verificationCodeTextField)
        addSubview(registerButton)
    }
    
    private func configureConstraints() {
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            phoneTextField.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            phoneTextField.widthAnchor.constraint(equalToConstant: 200),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verifyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            verifyButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            verifyButton.widthAnchor.constraint(equalToConstant: 100),
            verifyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        verificationCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verificationCodeTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            verificationCodeTextField.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 20),
            verificationCodeTextField.widthAnchor.constraint(equalToConstant: 200),
            verificationCodeTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: verificationCodeTextField.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: 100),
            registerButton.heightAnchor.constraint(equalToConstant: 30)
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
        viewModel.register(with: .phone) { if success {
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
}


