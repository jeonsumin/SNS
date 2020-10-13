//
//  EditProfileViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

struct EditProfileForModel {
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController,UITableViewDataSource {
    
    
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return table
    }()
    
    private var models = [[EditProfileForModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancel))
    }
    private func configureModel(){
        //name, username, website, bio
        let section1Labels = ["Name", "Username","Bio"]
        var secton1 = [EditProfileForModel]()
        for label in section1Labels {
            let model = EditProfileForModel(label: label, placeholder: "Enter\(label)", value: nil)
            secton1.append(model)
        }
        models.append(secton1)
        
        
        //emial, phone, gender
        
        let section2Labels = ["Email", "Phone","Gender"]
        var secton2 = [EditProfileForModel]()
        for label in section2Labels {
            let model = EditProfileForModel(label: label, placeholder: "Enter\(label)", value: nil)
            secton2.append(model)
        }
        models.append(secton2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK:- tableView
    
    private func  createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height / 3).integral)
        
        let size = header.height / 1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size) / 2,
                                                        y: (header.height-size)/2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size / 2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapProfilePhotoButton),
                                     for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                              for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    @objc private func didTapProfilePhotoButton() {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        let model = models[indexPath.section][indexPath.row]
        
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else  {
            return nil
        }
        return "Private Infomation"
    }
    
    @objc private func didTapSave(){
            //save info to database
        dismiss(animated: true, completion: nil)
    }
    @objc private func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "프로필 사진", message: "프로필사진 변경", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진",
                                            style: .default,
                                            handler: {_ in
                                                
        }))
        actionSheet.addAction(UIAlertAction(title: "앨범",
                                            style: .default,
                                            handler: {_ in
                                                
        }))
        actionSheet.addAction(UIAlertAction(title: "취소",
                                            style: .cancel,
                                            handler: {_ in
                                                
        }))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds 
        present(actionSheet,animated: true)
    }
}
extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileForModel) {
        //Update the model
        
    }
    
    
}
