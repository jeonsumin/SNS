//
//  EditProfileViewController.swift
//  SNS
//
//  Created by Terry on 2020/10/12.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
    }
    @objc private func didTapSave(){
        
    }
    @objc private func didTapCancel(){
        
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
