//
//  IGFeedPostTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//
import AVFoundation
import SDWebImage
import UIKit


// 기본 게시물 콘텐츠와 사진 콘텐츠
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = nil
        image.clipsToBounds = true
        return image
    }()
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post : UserPost){
        postImageView.image = UIImage(named: "test")
        
        
        return
        switch post.postType {
        case .photo :
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video :
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    //재사용 구현
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}
