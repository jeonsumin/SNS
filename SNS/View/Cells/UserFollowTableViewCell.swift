//
//  UserFollowTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/14.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(modle: String)
}

class UserFollowTableViewCell: UITableViewCell {

 static let identifier = "UserFollowTableViewCell"
    
    weak var delegate: UserFollowTableViewCell?
    
    private let profileImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let nameLabel: UILabel = {
       let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = .systemFont(ofSize: 17, weight: .semibold)
        return lb
    }()
    
    private let usernameLabel: UILabel = {
       let lb = UILabel()
        lb.numberOfLines = 1
        lb.font = .systemFont(ofSize: 17, weight: .regular)
        return lb
    }()
    
    private let followButton: UIButton = {
       let btn = UIButton()
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
    }
    public func configure(with model: String){
        
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
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
