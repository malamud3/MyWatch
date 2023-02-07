//
//  APICaller_FireBase.swift
//  MyWatch
//
//  Created by Amir Malamud on 03/02/2023.
//

import Foundation
import RxSwift
import FirebaseAuth

class APICaller_FireBase {
    
    static let shared = APICaller_FireBase()

    static func registerWithFirebaseEmail(email: String, password: String) -> Single<Result<AuthDataResult, Error>> {
      return Single.create(subscribe: { single -> Disposable in
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
          do {
            let result = try error.map { throw $0 } ?? result!
            single(.success(Result { result }))
          } catch {
            single(.success(Result { throw error }))
          }
        })
        return Disposables.create()
      })
    }
    
    static func loginWithFirebaseEmail(email: String, password: String) -> Single<Result<AuthDataResult, Error>> {
        return Single.create(subscribe: { single -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
                do {
                    let result = try error.map { throw $0 } ?? result!
                    single(.success(Result { result }))
                } catch {
                    single(.success(Result { throw error }))
                }
            })
            return Disposables.create()
        })
    }

    
    
    
    
}
