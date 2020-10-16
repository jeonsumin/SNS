//
//  IGFeedPostActionsTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit


protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapcommentButton()
    func didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostActionsTableViewCell"

    weak var delegate :IGFeedPostActionsTableViewCellDelegate?
    private let likeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .label
        return button
    }()
    private let commentButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .label
        return button
    }()
    private let sendButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .label
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapcommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    @objc private func didTapLikeButton(){
        delegate?.didTapLikeButton()
    }
    @objc private func didTapcommentButton(){
        delegate?.didTapcommentButton()
    }
    @objc private func didTapSendButton(){
        delegate?.didTapSendButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost){
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //좋아요, 댓글, 전송
        let buttonSize = contentView.height-10
        let buttons = [likeButton,commentButton,sendButton]
        
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10*CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
