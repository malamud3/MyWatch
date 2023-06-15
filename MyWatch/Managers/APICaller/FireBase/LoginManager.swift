//
//  LoginManager.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//

import FirebaseAuth
import AuthenticationServices

enum LoginError: Error {
    case invalidCredentials
}

class LoginManager {
    
    // MARK: - Properties

    var verificationID: String?
    var verificationCode: String?
    // MARK: - Phone Number Login
    
    func login(withPhoneNumber phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.verificationID = verificationID
                completion(.success(verificationID ?? ""))
            }
        }
    }
    
    func verifyPhoneNumber(verificationCode: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let verificationID = verificationID else {
            completion(.failure(LoginError.invalidCredentials))
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = result {
                completion(.success("Successfully verified phone number."))
            } else {
                completion(.failure(LoginError.invalidCredentials))
            }
        }
    }
    
    // MARK: - Apple ID Login
    
    func login(withAppleIDCredential credential: ASAuthorizationAppleIDCredential, completion: @escaping (Result<String, Error>) -> Void) {
        let idToken = String(data: credential.identityToken!, encoding: .utf8)!
        let nonce = UUID().uuidString

        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: nonce)

        Auth.auth().signIn(with: firebaseCredential) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = result {
                completion(.success("Successfully logged in with Apple ID."))
            } else {
                completion(.failure(LoginError.invalidCredentials))
            }
        }
    }
    
    // MARK: - Google Login
    
    func login(withGoogleIDToken idToken: String, accessToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = result {
                completion(.success("Successfully logged in with Google."))
            } else {
                completion(.failure(LoginError.invalidCredentials))
            }
        }
    }
}
