//
//  NotificationFollowEventTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/14.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate:AnyObject {
    func didTapFoloowUnFollowButton(model: String)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
       let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let lable: UILabel = {
       let lb = UILabel()
        lb.textColor = .label
        lb.numberOfLines = 1
        
        return lb
    }()
    
    private let followButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(lable)
        contentView.addSubview(followButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: String){
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        lable.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
