//
//  NotificationView.swift
//  SNS
//
//  Created by Terry on 2020/10/14.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    private let lable: UILabel = {
       let lb = UILabel()
        lb.text = "알림이 없습니다."
        lb.textColor = .secondaryLabel
        lb.textAlignment = .center
        lb.numberOfLines = 1
        
        return lb
    }()
    
    private let imageView: UIImageView = {
       let image = UIImageView()
        image.tintColor = .secondaryLabel
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "bell")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lable)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(
            x: (width-50)/2,
            y: 0,
            width: 50,
            height: 50
        ).integral
        
        lable.frame = CGRect(
            x: 0,
            y: imageView.bottom,
            width: width,
            height: height-50
        ).integral
    }
}
