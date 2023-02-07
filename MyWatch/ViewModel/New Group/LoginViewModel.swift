//
//  LoginViewModel.swift
//  GameStore_UIkit
//
//  Created by Amir Malamud on 02/02/2023.
//

import RxSwift
import FirebaseAuth

class LoginViewModel {
  let email = PublishSubject<String>()
  let password = PublishSubject<String>()
  let loginTapped = PublishSubject<Void>()

  var isLoginEnabled: Observable<Bool>
  var loginSuccess: Observable<Bool>

    init() {
        isLoginEnabled = Observable.combineLatest(email, password) { email, password in
            return email.isValidEmail() && password.count >= 4
        }
        
        loginSuccess = loginTapped
            .withLatestFrom(Observable.combineLatest(email, password))
            .flatMap { email, password in
                return APICaller_FireBase.loginWithFirebaseEmail(email: email, password: password)
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
