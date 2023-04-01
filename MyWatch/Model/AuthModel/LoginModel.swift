//
//  LoginModel.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//

import FirebaseAuth

struct LoginModel {
    let phoneNumber: String
    var verificationCode: String?
    
    var googleCredential: AuthCredential?
    var googleIDToken: String?
    var googleAccessToken: String?
    
    var appleCredential: AuthCredential?
    var appleIdentityToken: Data?
    var appleNonce: String?
}




