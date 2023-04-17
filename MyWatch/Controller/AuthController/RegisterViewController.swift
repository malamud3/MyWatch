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
        let model = RegistrationModel()
        return RegistrationViewModel(model: model)
    }()
    
    var registrationView: RegistrationView!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationView = RegistrationView(viewModel: viewModel)

        registrationView.translatesAutoresizingMaskIntoConstraints = false // disable autoresizing masks
        
        
        view.addSubview(registrationView)
        
        NSLayoutConstraint.activate([
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationView.topAnchor.constraint(equalTo: view.topAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

