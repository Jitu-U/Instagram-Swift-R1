//
//  AuthManager.swift
//  Instagram
//
//  Created by Jitesh gamit on 26/05/21.
//


import FirebaseAuth
import FirebaseDatabase
public class AuthManager{
    static let shared = AuthManager()
    
    //Mark:- Public APIs
    public func registerNewUser(username: String, email: String, Password: String, completion: @escaping (Bool) -> Void){
        
        /*
         1. check if email is available
         2. check if username is available
         */
        DatabaseManager.shared.isUserNotListed(with: email, username: username){ canCreate in
            if canCreate {
               /*
                 3. register user
                 */
                
                Auth.auth().createUser(withEmail: email, password: Password) { result, error in
                    guard error == nil, result != nil else {
                        //firebase Auth could not create account
                        completion(false)
                        return
                    }
                    
                    // 4. add user to database
                    DatabaseManager.shared.addUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else{
                            //failed to insert to database
                            completion(false)
                            return
                        }
                    }
                    
                    
                }
            }
            else{
                //either username or email does not exist
                completion(false)
            }
        }
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)){
        if let email = email {
            //Email Login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
        else if let username = username{
           //Username Login
            
        }
    }
    
    
    /// Logout firebase user 
    public func logOut(completion: (Bool)-> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch  {
            print(error)
            completion(false)
           return
        }
    }
    
}

