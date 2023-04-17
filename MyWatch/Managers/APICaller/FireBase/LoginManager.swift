////
////  LoginManager.swift
////  MyWatch
////
////  Created by Amir Malamud on 01/04/2023.
////
//
//import Foundation
//import FirebaseAuth
//import AuthenticationServices
//import GoogleSignIn
//
//class LoginManager {
//    func login(withPhoneNumber phoneNumber: String, verificationCode: String, completion: @escaping (Bool, Error?) -> Void) {
//        // Use the verification code to sign in with Firebase
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: verificationCode)
//        Auth.auth().signIn(with: credential) { authResult, error in
//            if let error = error {
//                // Handle authentication error
//                completion(false, error)
//                return
//            }
//            
//            completion(true, nil)
//        }
//    }
//    
//    func login(withAppleIDCredential credential: ASAuthorizationAppleIDCredential, completion: @escaping (Bool, Error?) -> Void) {
//        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: String(data: credential.identityToken!, encoding: .utf8)!, accessToken: "")
//        Auth.auth().signIn(with: firebaseCredential) { authResult, error in
//            if let error = error {
//                // Handle authentication error
//                completion(false, error)
//                return
//            }
//            
//            completion(true, nil)
//        }
//    }
//
//    
//    func login(withGoogleIDToken idToken: String, accessToken: String, completion: @escaping (Bool, Error?) -> Void) {
//        // Use the ID token and access token to sign in with Firebase
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//        Auth.auth().signIn(with: credential) { authResult, error in
//            if let error = error {
//                // Handle authentication error
//                completion(false, error)
//                return
//            }
//            
//            // Authentication successful
//            completion(true, nil)
//        }
//    }
//}
