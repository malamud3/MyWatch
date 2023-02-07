//
//  RegisterViewModel.swift
//  MyWatch
//
//  Created by Amir Malamud on 03/02/2023.
//

import RxSwift
import FirebaseAuth

class RegisterViewModel {
  let email = PublishSubject<String>()
  let password = PublishSubject<String>()
  let registerTapped = PublishSubject<Void>()
  
  var isRegisterEnabled: Observable<Bool>
  var registerSuccess: Observable<Bool>
  
  init() {
    isRegisterEnabled = Observable.combineLatest(email, password) { email, password in
        return email.isValidEmail() && password.count >= 4
    }
    
    registerSuccess = registerTapped
      .withLatestFrom(Observable.combineLatest(email, password))
      .flatMap { email, password in
        return APICaller_FireBase.registerWithFirebaseEmail(email: email, password: password)
          .map { result in
        switch result {
          case .success:
            return true
          case .failure:
            return false
        }
          }
          .catchAndReturn(false)
      }
  }
}

