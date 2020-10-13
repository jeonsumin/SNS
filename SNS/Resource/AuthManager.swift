//
//  AuthManager.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    //MARK:-Public
    
    //신규 회원가입
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void ){
        /* 체크 사항
         이메일이 있는지,
         유저이름이 있는지
         확인 후 계성 생성 후 database insert
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        // 실패했을 경우
                        completion(false)
                        return
                    }
                    //데이터베이스 insert
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { (success) in
                        if success {
                            completion(true)
                            return
                        }else{
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                // 이메일 또는 이름이 없을경우
                completion(false)
            }
        }
    }
    
    //로그인 인증
    public func loginUser(username: String?, email:String?, password: String, completion :@escaping (Bool) -> Void ) {
        if let email = email {
            // 이메일 로그인
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
    
    ///LogOut Firebase
    public func logOut(completion: (Bool)-> Void) {
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error)
            completion(false)
            return
        }
    }
}
