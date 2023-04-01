////
////  LoginViewController.swift
////  MyWatch
////
////  Created by Amir Malamud on 01/04/2023.
////
//
////
////  LoginViewController.swift
////  MyWatch
////
////  Created by Amir Malamud on 01/04/2023.
////
//
//import UIKit
//import AuthenticationServices
//import GoogleSignIn
//
//class LoginViewController: UIViewController {
//
//    private let loginView = LoginView()
//    private let model = LoginModel(phoneNumber: "")
//    private let loginManager = LoginManager()
//    private var viewModel: LoginViewModel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel = LoginViewModel(model: model, loginManager: loginManager)
//        loginView.loginButtonAction = { [weak self] phoneNumber in
//            self?.viewModel.login(with: phoneNumber, completion: (Bool, Error?) -> Void)
//        }
//    }
//
//    // rest of your LoginViewController implementation
//}
