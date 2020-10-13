//
//  PhotoCollectionViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post Image"
        accessibilityHint = "Double-tap to oepn post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("not image")
    }
    public func configure(with model: UserPost){
        let url = model.thumbnailImage
        photoImageView.sd_setImage(with: url, completed: nil)
    }
    public func configure(debug imageName: String){
        photoImageView.image = UIImage(named: imageName)
    }
}
