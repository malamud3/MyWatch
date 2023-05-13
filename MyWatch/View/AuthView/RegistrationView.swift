


//  RegistrationView.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//
//
//  RegistrationView.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.


import UIKit
import MaterialComponents

import GoogleSignIn
import GoogleSignInSwift



class RegistrationView: UIView {
    
    // MARK: - Properties
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: S.picName.Logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black // or any other desired tint color
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Logo Image"
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Sign In"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let typographyScheme = MDCTypographyScheme()
        typographyScheme.headline1 = UIFont.systemFont(ofSize: 24, weight: .bold)
        let colorScheme = MDCSemanticColorScheme()
        label.textColor = colorScheme.onSurfaceColor
        
        let titleColor = colorScheme.onSurfaceColor
        
        return label
    }()


    
    let viewModel: RegistrationViewModel

    lazy var phoneTextField: MDCOutlinedTextField = {
          let textField = MDCOutlinedTextField()
          textField.label.text = "Phone Number"
          textField.label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
          textField.keyboardType = .phonePad
          textField.leadingAssistiveLabel.text = "Enter your phone number"
          textField.sizeToFit()

          // Customize text field appearance
          textField.setOutlineColor(UIColor.lightGray, for: .normal)
          textField.setOutlineColor(UIColor.systemBlue, for: .editing)
          textField.setOutlineColor(UIColor.lightGray, for: .disabled)
          textField.setFloatingLabelColor(UIColor.systemBlue, for: .editing)
          textField.setFloatingLabelColor(UIColor.lightGray, for: .normal)
          textField.setLeadingAssistiveLabelColor(UIColor.lightGray, for: .normal)
          textField.setLeadingAssistiveLabelColor(UIColor.systemBlue, for: .editing)

          return textField
      }()


    lazy var verifyButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleFont(UIFont.systemFont(ofSize: 30, weight: .medium), for: .normal)
        button.setTitleFont(UIFont(name: "AvenirNext-DemiBold", size: 40), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setElevation(ShadowElevation(rawValue: 4), for: .normal)
        button.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
        button.applyCustomContainedButtonStyle()

        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        verifyButton.layer.cornerRadius = verifyButton.frame.height / 20
    }



    lazy var verificationCodeTextField: MDCOutlinedTextField = {
        let textField = MDCOutlinedTextField()
        textField.placeholder = "Verification Code"
        textField.isHidden = true
        textField.keyboardType = .numberPad
        textField.label.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        // Customize text field appearance
        textField.setOutlineColor(UIColor.systemGray3, for: .normal)
        textField.setOutlineColor(UIColor.systemBlue, for: .editing)
        textField.setOutlineColor(UIColor.systemGray, for: .disabled)
        textField.setFloatingLabelColor(UIColor.systemBlue, for: .editing)
        textField.setFloatingLabelColor(UIColor.gray.withAlphaComponent(0.6), for: .normal)
        textField.setLeadingAssistiveLabelColor(UIColor.gray.withAlphaComponent(0.6), for: .normal)
        textField.setLeadingAssistiveLabelColor(UIColor.systemBlue, for: .editing)

        return textField
    }()

    lazy var registerButton: MDCButton = {
        let button = MDCButton()
                button.setTitle("Register", for: .normal)
                button.setTitleFont(UIFont(name: "AvenirNext-DemiBold", size: 40), for: .normal)
                button.setTitleColor(UIColor.white, for: .normal)
                button.setElevation(ShadowElevation(rawValue: 10), for: .normal)
                button.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
                button.applyCustomContainedButtonStyle()
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()

    lazy var appleButton: UIButton = {
        let button = UIButton.createMetallicButton(withImageNamed:  S.picName.Icon_apple)
        button.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
        return button
    }()

    lazy var googleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .standard
        button.colorScheme = .dark
        button.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        return button
    }()

    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [googleButton, appleButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()


    lazy var cardView: MDCCard = {
        let view = MDCCard()
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = false
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale


        // Create overlay view
        let overlayView = UIView()
        overlayView.frame = view.bounds
        overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(overlayView)

        // Apply shadow to overlay view
        overlayView.layer.cornerRadius = view.layer.cornerRadius
        overlayView.layer.shadowColor = UIColor.white.cgColor
        overlayView.layer.shadowOpacity = 1.0
        overlayView.layer.shadowRadius = 10.0
        overlayView.layer.shadowOffset = CGSize(width: 0, height: 5)

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
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(cardView)
         cardView.addSubview(phoneTextField)
         cardView.addSubview(verifyButton)
         cardView.addSubview(verificationCodeTextField)
         cardView.addSubview(registerButton)
         addSubview(buttonStackView)
    }

    private func configureConstraints() {
        // cardView
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: widthAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 400),
        ])
        
        // logoImageView
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
        
        // phoneTextField
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor, constant: -20),
            phoneTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50),
            phoneTextField.widthAnchor.constraint(equalToConstant: 250),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30)
        ])

        // verifyButton
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verifyButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            verifyButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            verifyButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            verifyButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
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

        // buttonStackView
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
        ])

        // appleButton
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            appleButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
        ])

        // googleButton
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            googleButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            googleButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
        ])
    }



    // MARK: - Actions

    @objc private func didTapVerifyButton()   {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            return
        }
        Task {
            do {
                viewModel.model.phoneNumber = phoneNumber
                try await viewModel.register(with: .phone) { success, error in
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
        }
    }

    @objc private func didTapRegisterButton()   {
        guard let verificationCode = verificationCodeTextField.text else {
            return
        }
        Task {
            do {
                viewModel.registrationManager.verificationCode = verificationCode
                try await viewModel.register(with: .sms) { success,error  in
                    if success {
                        // Display success message and clear text fields
                        self.phoneTextField.text = ""
                        self.verificationCodeTextField.text = ""
                        
                        // Hide verification code text field and register button
                        self.verificationCodeTextField.isHidden = true
                        self.registerButton.isHidden = true
                        
                        // Show phone text field and verify button
                        self.phoneTextField.isHidden = false
                        self.verifyButton.isHidden = false
                        
                        // Show success message
                        let message = MDCSnackbarMessage()
                        message.text = "Registration successful!"
                        MDCSnackbarManager.default.show(message)
                        // Move to a new controller
                        
                    } else {
                        // Show success message
                        let message = MDCSnackbarMessage(text: error ?? "Registration failed")
                        MDCSnackbarManager.default.show(message)
                        self.verificationCodeTextField.text = ""
                    }
                }
            }
        }
    }
    
    @objc private func didTapAppleButton()  {
        Task {
            do {
                try await viewModel.register(with: .apple) { success, error in
                    if let error = error {
                        // Display error message
                        print("Apple sign-in failed: \(error)")
                    } else if success {
                        // Do something
                    }
                }
            }catch {
                // Handle error
                print(error)
            }
        }
    }

    @objc private func didTapGoogleButton() {
        Task {
            do {
                try await viewModel.register(with: .google) { success, error in
                    if let error = error {
                        // Display error message
                        print(error)
                    } else if success {
                        // Do something
                    }
                }
            } catch {
                // Handle error
                print(error)
            }
        }
    }
    

}


