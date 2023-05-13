//
//  RegisterViewModel.swift
//  MyWatch
//
//  Created by Amir Malamud on 03/02/2023.
//

import AuthenticationServices
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class RegistrationViewModel {
    
    // MARK: - Properties
    let registrationManager: RegistrationManager
    
    var model: User
    
    typealias AuthResult = Result<AuthDataResult, Error>
    typealias AuthCompletion = (_ result: AuthResult) -> Void
    
    // MARK: - Initialization
    
    init(model: User, registrationManager: RegistrationManager) {
        self.model = model
        self.registrationManager = registrationManager
    }
    
    // MARK: - Actions
    
    func register(with method: AuthMethod, completion: @escaping (Bool, String?) -> Void) async throws  {
        switch method {
        case .phone:
            try await registerWithPhoneNumber(completion: completion)
        case .apple: break
            //    registerWithAppleID(completion: completion)
        case .google:
            try await registerWithGoogle(completion: completion)
        case .sms:
            try await verifyPhoneNumber(completion: completion)
        }
    }
    
    func registerWithPhoneNumber(completion: @escaping (Bool, String?) -> Void) async throws {
        guard let phoneNumber = model.phoneNumber, !phoneNumber.isEmpty else {
            completion(false, "Please enter a valid phone number.")
            return
        }
        registrationManager.register(withPhoneNumber: phoneNumber){ result in
            switch result {
            case .success:
                print("ALL GOOD")
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func verifyPhoneNumber(completion: @escaping (Bool, String?) -> Void) async throws{
        
        guard let verificationCode = registrationManager.verificationCode else {
            completion(false, "Please enter a valid phone number.")
            return
        }
        registrationManager.verifyPhoneNumber(verificationCode: verificationCode) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    
    
    
    func registerWithGoogle(completion: @escaping (Bool, String?) -> Void) async throws {
        
        // Configure Google Sign-In
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        let scenes = await UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = await windowScenes?.windows.first
        guard let rootViewController = await window?.rootViewController else { return }

        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        Task{
            let isGuidedAccessEnabled = UIAccessibility.isGuidedAccessEnabled
            print("Is Guided Access enabled? \(isGuidedAccessEnabled)")
        }

        registrationManager.register(withGoogleIDToken: idToken, accessToken: accessToken) { success, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(success, nil)
            }
        }
    }


}





