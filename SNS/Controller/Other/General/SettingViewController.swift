//
//  SettingViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}
/// 사용자 설정
final class SettingViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModel(){
        data.append([
            SettingCellModel(title: "프로필 수정") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "친구 초대") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "게시물 저장") { [weak self] in
                self?.didTapSaveOriginalPost()
            }
        ])
        
        data.append([
            SettingCellModel(title: "개인정보 보호 정책") { [weak self] in
                self?.openURL(type:.terms)
            }
        ])
        data.append([
            SettingCellModel(title: "서비스 약관 ") { [weak self] in
                self?.openURL(type:.privacy)
            }
        ])
        data.append([
            SettingCellModel(title: "Help /  FeedBack") { [weak self] in
                self?.openURL(type:.help)
            }
        ])
        
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    enum SettingURlType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingURlType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870?ref=dp"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    private func didTapSaveOriginalPost(){
        
    }
    
    private func didTapInviteFriends(){
        //친구 초대 공유 시트
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "프로필 수정"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC,animated: true)
    }
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "로그아웃 하시겠습니까??", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "로그아웃", style: .destructive  , handler: {_ in
            
            AuthManager.shared.logOut(completion: {success in
                DispatchQueue.main.async {
                    if success {
                        //success
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC,animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        //error
                        fatalError("로그아웃 하지 못하였습니다.")
                    }
                }
            })
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet,animated: true)
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       data[indexPath.section][indexPath.row].handler()
        
    }
    
}
