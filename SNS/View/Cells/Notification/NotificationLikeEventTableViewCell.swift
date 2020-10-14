//
//  NotificationLikeEventTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/14.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate:AnyObject {
    func didTapRelatedButton(model: String)
}

class NotificationLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
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
    
    private let postButton: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(lable)
        contentView.addSubview(postButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: String){
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        lable.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
