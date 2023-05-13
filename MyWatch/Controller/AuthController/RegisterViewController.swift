//
//  RegisterViewController.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//

import UIKit
import FirebaseCore


class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var viewModel: RegistrationViewModel = {
        let model = User()
        let registrationManager = RegistrationManager()
        return RegistrationViewModel(model: model, registrationManager: registrationManager)
    }()

    
    lazy var registrationView: RegistrationView = {
        let view = RegistrationView(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize registration view with view model
        registrationView = RegistrationView(viewModel: viewModel)
        
        // Add registration view to the view hierarchy
        view.addSubview(registrationView)
        registrationView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints
        NSLayoutConstraint.activate([
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationView.topAnchor.constraint(equalTo: view.topAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

