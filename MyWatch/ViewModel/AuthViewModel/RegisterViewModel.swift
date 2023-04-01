//
//  RegisterViewModel.swift
//  MyWatch
//
//  Created by Amir Malamud on 03/02/2023.
//

import FirebaseAuth

enum RegistrationMethod {
    case phone
    case apple
    case google
}

class RegistrationViewModel {
    
    // MARK: - Properties
    
    var model: RegistrationModel
    
    // MARK: - Initialization
    
    init(model: RegistrationModel) {
        self.model = model
    }
    
    // MARK: - Actions
    
    func register(with method: RegistrationMethod, completion: @escaping (Bool, String?) -> Void) {
        switch method {
        case .phone:
            registerWithPhoneNumber(completion: completion)
        case .apple:
            registerWithAppleID(completion: completion)
        case .google:
            registerWithGoogle(completion: completion)
        }
    }
    
    private func registerWithPhoneNumber(completion: @escaping (Bool, String?) -> Void) {
        guard let phoneNumber = model.phoneNumber else {
            completion(false, "Please enter a valid phone number.")
            return
        }
        
        // Configure Firebase Auth
        let auth = Auth.auth()
        auth.languageCode = Locale.current.languageCode
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else if let verificationID = verificationID {
                self.model.verificationCode = verificationID
                completion(true, nil)
            }
        }
    }
    
    private func registerWithAppleID(completion: @escaping (Bool, String?) -> Void) {
        guard let credential = self.model.appleCredential else {
            completion(false, "Missing Apple credential.")
            return
        }
        
        // Configure Firebase Auth
        let auth = Auth.auth()
        auth.languageCode = Locale.current.languageCode
        
        auth.signIn(with: credential) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else if authResult?.user != nil {
                // Handle new user registration
                completion(true, nil)
            }
        }
    }
    
    private func registerWithGoogle(completion: @escaping (Bool, String?) -> Void) {
        guard let credential = self.model.googleCredential else {
            completion(false, "Missing Google credential.")
            return
        }
        
        // Configure Firebase Auth
        let auth = Auth.auth()
        auth.languageCode = Locale.current.languageCode
        
        auth.signIn(with: credential) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else if authResult?.user != nil {
                // Handle new user registration
                completion(true, nil)
            }
        }
    }
}
