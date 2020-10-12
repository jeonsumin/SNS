//
//  LoginViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    //이메일 필드
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username Or Email"
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
    
    //로그인 버튼
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
       return button
    }()
    
    // 이용 약관 버튼
    private let termsButton: UIButton = {
       let button = UIButton()
        button.setTitle("서비스 약관", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    //개인정보 보호 정책
    private let privacyButton: UIButton = {
       let button = UIButton()
        button.setTitle("개인정보 보호 정책", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    //회원가입 버튼
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
       return button
    }()
    
    //topView
    private let headerView: UIView  = {
        let header = UIView()
        header.clipsToBounds = true
        //header 뷰에 이미지 넣기
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        
        // 뷰에 추가
        header.addSubview(backgroundImageView)
       return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        
        view.backgroundColor = .systemBackground
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 뷰 출력
        headerView.frame = CGRect(
            x: 0,
            y: 0.0, // 상단 노치까지 뷰가 올라감
            width: view.width,
            height: view.height / 3.0)
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52.0)
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 52.0)
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width - 20,
            height: 50)
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: 50)
        
        
        configureHeaderView()
        
    }
    
    private func configureHeaderView() {
        // header view 위치 잡기 
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //로고 추가
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width / 2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        
        view.addSubview(headerView)
    }
    @objc private func didTapLoginButton(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        //로그인 기능
        
    }
    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870?ref=dp") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        present(vc,animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
