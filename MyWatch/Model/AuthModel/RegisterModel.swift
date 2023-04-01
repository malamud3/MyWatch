//
//  RegisterModel.swift
//  MyWatch
//
//  Created by Amir Malamud on 01/04/2023.
//
import FirebaseAuth

struct RegistrationModel {
    var phoneNumber: String?
    var verificationCode: String?
    var googleCredential: AuthCredential?
    var appleCredential: AuthCredential?
}
