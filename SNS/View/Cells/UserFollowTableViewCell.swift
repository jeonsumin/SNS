//
//  UserFollowTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/14.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationShip)
}

enum FollowState {
    case following       // 현재사용자가 다른사용자를 팔로우하고 있음을 나타냄
    case not_following   // 현재 사용자가 다른사용자를 팔로우하지 않음을 나타냄 
}

struct UserRelationShip {
    let username: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

 static let identifier = "UserFollowTableViewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?

    private var model :UserRelationShip?
    
    private let profileImageView: UIImageView = {
       let image = UIImageView()
        image.layer.masksToBounds = true
        image.backgroundColor = .secondaryLabel
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let nameLabel: UILabel = {
       let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = .systemFont(ofSize: 17, weight: .semibold)
        lb.text = "안우진"
        return lb
    }()
    
    private let usernameLabel: UILabel = {
       let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = .systemFont(ofSize: 17, weight: .regular)
        lb.text = "@안우진"
        lb.textColor = .secondaryLabel
        return lb
    }()
    
    private let followButton: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .link
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowButton(){
        
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    public func configure(with model: UserRelationShip){
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            // 언팔 버튼 보여주기
            followButton.setTitle("팔로잉", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // 팔로우 버튼 보여주기
            followButton.setTitle("팔로우", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitleColor(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(
            x: 3,
            y: 3,
            width: contentView.height-6,
            height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(
            x: contentView.width-5-buttonWidth,
            y: (contentView.height-40)/2,
            width: buttonWidth,
            height: 40)
        
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(
            x: profileImageView.right + 5,
            y: 0,
            width: contentView.width-8-profileImageView.width,
            height: labelHeight)
        usernameLabel.frame = CGRect(
            x: profileImageView.right + 5,
            y: nameLabel.bottom,
            width: contentView.width-8-profileImageView.width,
            height: labelHeight)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
