//
//  RegistrationManager.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn

class RegistrationManager {
    
    // MARK: - Phone Registration
    
    func register(withPhoneNumber phoneNumber: String, completion: @escaping (String?, Error?) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(verificationID, nil)
            }
        }
    }
    func verifyPhoneNumber(phoneNumber: String, completion: @escaping (Bool, String?) -> Void) {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    completion(false, error.localizedDescription)
                } else if let verificationID = verificationID {
                    // Do something with verification ID
                    completion(true, verificationID)
                }
            }
        }
    // MARK: - Apple Registration
    
    func register(withAppleIDCredential credential: ASAuthorizationAppleIDCredential, completion: @escaping (Bool, Error?) -> Void) {
        let idToken = String(data: credential.identityToken!, encoding: .utf8)!
        let nonce = UUID().uuidString
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { authResult, error in
            if let error = error {
                completion(false, error)
            } else {
                let isNewUser = authResult?.additionalUserInfo?.isNewUser ?? false
                completion(isNewUser, nil)
            }
        }
    }
    
    // MARK: - Google Registration
    
    func register(withGoogleIDToken idToken: String, accessToken: String, completion: @escaping (Bool, Error?) -> Void) {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(false, error)
            } else {
                let isNewUser = authResult?.additionalUserInfo?.isNewUser ?? false
                completion(isNewUser, nil)
            }
        }
    }
}
