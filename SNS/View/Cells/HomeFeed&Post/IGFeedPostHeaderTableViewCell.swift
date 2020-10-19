//
//  IGFeedPostHeaderTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//
import SDWebImage
import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoerButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostHeaderTableViewCell"
    weak var delegate : IGFeedPostHeaderTableViewCellDelegate?
    private let profilePhotoImageView: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let usernameLabel : UILabel = {
       let lb = UILabel()
        lb.textColor = .label
        lb.numberOfLines = 1
        lb.font = .systemFont(ofSize: 18,weight: .medium)
        return lb
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for:.touchUpInside)
    }
    
    
    @objc private func didTapButton() {
        delegate?.didTapMoerButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model : User){
        usernameLabel.text = model.name
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
//        profilePhotoImageView.sd_setImage(with: <#T##URL?#>, completed: <#T##SDExternalCompletionBlock?##SDExternalCompletionBlock?##(UIImage?, Error?, SDImageCacheType, URL?) -> Void#>)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        profilePhotoImageView.frame = CGRect(
            x: 2,
            y: 2,
            width: size,
            height: size
        )
        profilePhotoImageView.layer.cornerRadius = size/2
        
        moreButton.frame = CGRect(
            x: contentView.width-size,
            y: 2,
            width: size,
            height: size
        )
        usernameLabel.frame = CGRect(
            x: profilePhotoImageView.right+10,
            y: 2,
            width: contentView.width-(size*2)-15,
            height: contentView.height-4
        )
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }
}
