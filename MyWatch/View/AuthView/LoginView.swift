import UIKit
import MaterialComponents
import AuthenticationServices
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginView: UIView {
    
    // MARK: - Properties
    
    let viewModel: LoginViewModel
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Sign In"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var loginButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Login", for: .normal)
        button.setTitleFont(UIFont.systemFont(ofSize: 30, weight: .medium), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setElevation(ShadowElevation(rawValue: 4), for: .normal)
        button.setBackgroundColor(UIColor.blue, for: .normal) // Example button background color
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var googleLoginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login with Google", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red // Example button background color
        button.addTarget(self, action: #selector(didTapGoogleLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .default, style: .black)
        button.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    init(viewModel: LoginViewModel) {
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
        addSubview(titleLabel)
        addSubview(phoneNumberTextField)
        addSubview(loginButton)
        addSubview(googleLoginButton)
        addSubview(appleLoginButton)
    }
    
    private func configureConstraints() {
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        // phoneNumberTextField
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        // googleLoginButton
        NSLayoutConstraint.activate([
            googleLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            googleLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            googleLoginButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // appleLoginButton
        NSLayoutConstraint.activate([
            appleLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleLoginButton.topAnchor.constraint(equalTo: googleLoginButton.bottomAnchor, constant: 20),
            appleLoginButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapLoginButton() async {
        // Perform the login action
        
        // Get the phone number from the text field
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            // Show an error message if the phone number is empty
            print("Please enter a valid phone number.")
            return
        }
        
        // Set the phone number in the view model
        viewModel.model.phoneNumber = phoneNumber
        
        do {
            let result: () = try await viewModel.login(with: .phone) { success, error in
                if success {
                    // Login successful
                    // You can handle the successful login action here
                    print("Login successful")
                } else if let error = error {
                    // Login failed
                    // You can handle the login failure and show an error message to the user
                    print("Login failed: \(error)")
                }
            }
            
            // Handle the result if necessary
            // ...
            
        } catch {
            // Handle any other errors that occur during the login process
            print("Error: \(error)")
        }
    }
    
    @objc private func didTapGoogleLoginButton() async {
        // Handle Google login button tap
        do {
            let result: () = try await viewModel.login(with: .google) { success, error in
                if success {
                    // Login successful
                    // You can handle the successful login action here
                    print("Google login successful")
                } else if let error = error {
                    // Login failed
                    // You can handle the login failure and show an error message to the user
                    print("Google login failed: \(error)")
                }
            }
            
            // Handle the result if necessary
            // ...
            
        } catch {
            // Handle any other errors that occur during the login process
            print("Error: \(error)")
        }
    }
    
    @objc private func didTapAppleLoginButton() {
        // Handle Apple login button tap
        // You can implement the Apple login flow here
    }
}
