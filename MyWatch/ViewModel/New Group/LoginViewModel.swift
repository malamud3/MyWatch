////
////  LoginViewModel.swift
////  GameStore_UIkit
////
////  Created by Amir Malamud on 02/02/2023.
////
//import Foundation
//import FirebaseAuth
//import GoogleSignIn
//
//enum LoginMethod {
//    case phone
//    case apple
//    case google
//}
//
//class LoginViewModel {
//
//    // MARK: - Properties
//
//    private var model: LoginModel
//    private let loginManager: LoginManager
//
//    // MARK: - Initializer
//
//    init(model: LoginModel, loginManager: LoginManager) {
//          self.model = model
//          self.loginManager = loginManager
//      }
//
//    // MARK: - Public methods
//
//    func login(with method: LoginMethod, completion: @escaping (Bool, Error?) -> Void) {
//        switch method {
//        case .phone:
//            loginWithPhoneNumber(completion: completion)
//        case .apple:
//            loginWithApple(completion: completion)
//        case .google:
//            loginWithGoogle(completion: completion)
//        }
//    }
//
//    // MARK: - Private methods
//
//    private func loginWithPhoneNumber(completion: @escaping (Bool, Error?) -> Void) {
//        guard let verificationCode = model.verificationCode else {
//            let error = NSError(domain: "LoginViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Verification code missing"])
//            completion(false, error)
//            return
//        }
//        let loginManager = LoginManager()
//        loginManager.login(withPhoneNumber: model.phoneNumber, verificationCode: verificationCode) { success, error in
//            completion(success, error)
//        }
//    }
//
//    private func loginWithApple(completion: @escaping (Bool, Error?) -> Void) {
//        guard let appleCredential = model.appleCredential, let identityTokenData = model.appleIdentityToken else {
//            let error = NSError(domain: "LoginViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Apple ID credential or identity token missing"])
//            completion(false, error)
//            return
//        }
//
//        guard let identityTokenString = String(data: identityTokenData, encoding: .utf8) else {
//            let error = NSError(domain: "LoginViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Apple ID identity token cannot be converted to string"])
//            completion(false, error)
//            return
//        }
//
//        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: identityTokenString, rawNonce: model.appleNonce)
//        self.model.appleCredential = credential
//
//        Auth.auth().signIn(with: credential) { (result, error) in
//            if let error = error {
//                completion(false, error)
//                return
//            }
//            completion(true, nil)
//        }
//    }
//
//
//
//
//
//
//    private func loginWithGoogle(completion: @escaping (Bool, Error?) -> Void) {
//        guard let idToken = model.googleIDToken, let accessToken = model.googleAccessToken else {
//            let error = NSError(domain: "LoginViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Google ID token or access token missing"])
//            completion(false, error)
//            return
//        }
//
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//        self.model.googleCredential = credential
//
//        let loginManager = LoginManager()
//        loginManager.login(withGoogleIDToken: idToken, accessToken: accessToken) { success, error in
//            completion(success, error)
//        }
//    }
//
//}
//
//
