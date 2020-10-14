//
//  ProfileInfoHeaderCollectionReusableView.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate:AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowerButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}


final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    private let profilePhotoImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.masksToBounds = true
        return image
    }()
    
    private let postsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("게시물", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        return btn
    }()
    private let followingButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("팔로잉", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        return btn
    }()
    private let followersButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("팔로워", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        return btn
    }()
    private let EditProfileButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("프로필 수정", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        return btn
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "jeon sumin"
        lb.textColor = .label
        lb.numberOfLines = 1
        
        return lb
    }()
    
    private let bioLabel: UILabel = {
        let lb = UILabel()
        lb.text = "첫번째 계정"
        lb.textColor = .label
        lb.numberOfLines = 0 // 줄 바꿈
        
        return lb
    }()
    
    
    //MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    
    private func addButtonActions(){
        followersButton.addTarget(
            self,
            action: #selector(didTapFollowerButton),
            for: .touchUpInside
        )
        followingButton.addTarget(
            self,
            action: #selector(didTapFollowingButton),
            for: .touchUpInside
        )
        postsButton.addTarget(
            self,
            action: #selector(didTapPostsButtonButton),
            for: .touchUpInside
        )
        EditProfileButton.addTarget(
            self,
            action: #selector(didTapEditProfileButton),
            for: .touchUpInside
        )
        
    }
    
    private func addSubviews(){
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(EditProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral
            
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        postsButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral

        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral

        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral

        EditProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth*3,
            height: buttonHeight
        ).integral
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width-10,
            height: 50
        ).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width-10,
            height: bioLabelSize.height
        ).integral
    }

    
    //MARK:- Action
    @objc private func didTapFollowerButton(){
        delegate?.profileHeaderDidTapFollowerButton(self)
    }
    @objc private func didTapFollowingButton(){
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapPostsButtonButton(){
        delegate?.profileHeaderDidTapPostButton(self)
    }
    @objc private func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
}
