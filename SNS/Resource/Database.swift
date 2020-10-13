//
//  Database.swift
//  
//
//  Created by Terry on 2020/10/12.
//

import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
   
    private let database = Database.database().reference()
    //MARK:- Public
    
    /// check Useranem and email
    /// - Param
    ///     - email
    ///     - username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void ) {
        completion(true)
    }
    
    /// inser new User Database
    /// - Param
    ///     - email
    ///     - username
    ///     - completion: async collback database result
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()
        
        
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                // insert success
                completion(true)
                return
            }else{
                //insert failed
                completion(false)
                return
            }
        }
    }
    
    
}
