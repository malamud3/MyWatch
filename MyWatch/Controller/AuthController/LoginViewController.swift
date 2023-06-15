//
//  LoginViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 15/06/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var viewModel: LoginViewModel = {
        let model = User()
        let loginManager = LoginManager()
        return LoginViewModel(model: model, loginManager: loginManager)
    }()
    
    lazy var loginView: LoginView = {
        let view = LoginView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add login view to the view hierarchy
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
