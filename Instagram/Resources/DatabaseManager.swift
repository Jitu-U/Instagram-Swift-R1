//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Jitesh gamit on 26/05/21.
//


import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //mark :- public
    
    /// check if username and email is available
    /// - Parameters
    ///  -  email: String representing email
    ///  - username: String represnting username
    
    public func isUserNotListed(with email: String, username: String, completion:((Bool) -> Void)){
        completion(true)
    }
    /// check if username and email is available
    /// - Parameters
    ///  -  email: String representing email
    ///  - username: String represnting username
    ///  - completion: async callback for  results if database entry succeeded 
    
    public func addUser(with email: String, username: String, completion: @escaping (Bool) -> Void ){
        
        let key = email.safeDatabaseKey()
        print(key)
        
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                //Suceed
                completion(true)
                return
            }
            else{
                //failed
                completion(false)
                return
            }
        }
    }
}

