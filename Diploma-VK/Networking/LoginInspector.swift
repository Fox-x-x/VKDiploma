//
//  LoginInspector.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 10.01.2024.
//

import Foundation
import FirebaseAuth

class LoginInspector {
    private let defaults = UserDefaults.standard
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
            defaults.set(false, forKey: "isAuthorized")
        } catch let signOutError as NSError {
            throw ApiError.signOutError
        }
    }
    
    func registerUser(email: String, pass: String, completion: @escaping (Result<User, ApiError>) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
            if error != nil {
                completion(.failure(.createUserError))
            } else {
                if let createdUser = authResult?.user {
                    completion(.success(createdUser))
                } else {
                    completion(.failure(.authError))
                }
            }
        }
    }
    
    func loginOrRegisterUser(email: String, pass: String, completion: @escaping (Result<User, ApiError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let self else { return }
            
            guard error != nil else {
                // logged in succsessfuly, goToProfile
                if let loggedInUser = authResult?.user {
                    defaults.set(true, forKey: "isAuthorized")
                    completion(.success(loggedInUser))
                } else {
                    print("other error: cannot get user from FireBase")
                    completion(.failure(.authError))
                }
                return
            }
            
            guard let error = error as? NSError else { completion(.failure(.authError)); return }
            let errorCode = AuthErrorCode.Code(rawValue: error.code) ?? .networkError
            switch errorCode {
                case .userNotFound:
                    // register new user
                    self.registerUser(email: email, pass: pass) { result in
                        switch result {
                        case .failure(let error):
                            completion(.failure(error))
                        case .success(let user):
                            completion(.success(user))
                        }
                    }
                case .wrongPassword:
                    completion(.failure(.wrongPassword))
                case .invalidEmail:
                    completion(.failure(.invalidEmail))
                default:
                    completion(.failure(.authError))
            }
        }
    }
    
}
