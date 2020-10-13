//
//  SettingViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit
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
        let section = [
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ]
        data.append(section)
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
