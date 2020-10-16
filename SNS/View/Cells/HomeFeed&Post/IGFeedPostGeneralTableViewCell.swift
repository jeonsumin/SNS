//
//  IGFeedPostGeneralTableViewCell.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

/// Comments
class IGFeedPostGeneralTableViewCell: UITableViewCell {
 
 static let identifier = "IGFeedPostGeneralTableViewCell"
 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style:style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .systemOrange
 }
 
 required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
 }
 
 public func configure(){
     
 }
 override func layoutSubviews() {
     super.layoutSubviews()
 }
}
