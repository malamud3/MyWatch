//
//  RegistrationManager.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//
import FirebaseAuth

enum RegistrationError: Error {
    case verificationIDNotFound
}

class RegistrationManager {
    
    // MARK: - Properties

    var verificationCode: String?
    var verificationID: String?

    var googleCredential: AuthCredential?
    
    private var currentNonce: String?

    // MARK: - Phone Registration
    
    func register(withPhoneNumber phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    self.verificationID = verificationID
                    completion(.success(verificationID ?? ""))
                }
            }
        }

        func verifyPhoneNumber(verificationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let verificationID = verificationID else {
                completion(.failure(RegistrationError.verificationIDNotFound))
                return
            }
            // Create a credential object with the verification ID and verification code
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)

            // Use the credential to sign in the user or create a new account if they don't exist
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
            }
        }
    
    // MARK: - Apple Registration
    
//    func register(withAppleIDCredential credential: ASAuthorizationAppleIDCredential, completion: @escaping (Bool, Error?) -> Void) {
//        let idToken = String(data: credential.identityToken!, encoding: .utf8)!
//        let nonce = UUID().uuidString
//
//        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idToken, rawNonce: nonce)
//
//        Auth.auth().signIn(with: firebaseCredential) { authResult, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//        }
//    }
//
//    func randomNonceString(length: Int = 32) -> String {
//          precondition(length > 0)
//          let charset: Array<Character> =
//              Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//          var result = ""
//          var remainingLength = length
//
//          while remainingLength > 0 {
//              let randoms: [UInt8] = (0 ..< 16).map { _ in
//                  var random: UInt8 = 0
//                  let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//                  if errorCode != errSecSuccess {
//                      fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
//                  }
//                  return random
//              }
//
//              randoms.forEach { random in
//                  if remainingLength == 0 {
//                      return
//                  }
//
//                  if random < charset.count {
//                      result.append(charset[Int(random)])
//                      remainingLength -= 1
//                  }
//              }
//          }
//
//          return result
//      }
    
    
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
