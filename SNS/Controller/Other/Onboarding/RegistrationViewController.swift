//
//  RegistrationViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    //이메일 필드
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next  //키보드 리턴 타입
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no //자동 수정 유형
        field.autocapitalizationType = .none // 자동대문자 유형
        field.layer.masksToBounds = true //모서리 둥글게하기위해 ?
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }() // 익명 클로저
    
    private let EmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next  //키보드 리턴 타입
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no //자동 수정 유형
        field.autocapitalizationType = .none // 자동대문자 유형
        field.layer.masksToBounds = true //모서리 둥글게하기위해 ?
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    //비밀번호 필드
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue  //키보드 리턴 타입
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no //자동 수정 유형
        field.autocapitalizationType = .none // 자동대문자 유형
        field.layer.masksToBounds = true //모서리 둥글게하기위해 ?
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    //회원가입 버튼
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .systemBackground

          registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        usernameField.delegate = self
        EmailField.delegate = self
        passwordField.delegate = self
        
          view.addSubview(usernameField)
          view.addSubview(EmailField)
          view.addSubview(passwordField)
          view.addSubview(registerButton)
        
      }
      
      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          
          usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width-40, height: 52)
          EmailField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width-40, height: 52)
          passwordField.frame = CGRect(x: 20, y: EmailField.bottom + 10, width: view.width-40, height: 52)
          registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width-40, height: 52)
          
      }
    
    
    @objc private func didTapRegister(){
        EmailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = EmailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty,
            let username = usernameField.text, !username.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { (registered) in
            DispatchQueue.main.async {
                
                if registered {
                    //success
                    
                }else{
                    //failed
                }
            }
        }
    }
}
extension RegistrationViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            EmailField.becomeFirstResponder()
        }else if textField == EmailField {
            passwordField.becomeFirstResponder()
        }else {
            didTapRegister()
        }
        return true
    }
}
