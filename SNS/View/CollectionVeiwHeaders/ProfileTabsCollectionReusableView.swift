//
//  ProfileTabsCollectionReusableView.swift
//  SNS
//
//  Created by Terry on 2020/10/13.
//  Copyright © 2020 Terry. All rights reserved.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtontab()
    func didTapTaggeduttonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"

    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?

    struct Constans {
        static let padding: CGFloat = 8
    }
    
    private let gridButton: UIButton = {
       let btn = UIButton()
        btn.clipsToBounds = true
        btn.tintColor = .systemBlue
        btn.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        
        return btn
    }()
    private let taggedButton: UIButton = {
       let btn = UIButton()
        btn.clipsToBounds = true
        btn.tintColor = .lightGray
        btn.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        
        gridButton.addTarget(
            self,
            action: #selector(didTapGridButton),
            for: .touchUpInside)
        taggedButton.addTarget(
        self,
        action: #selector(didTapTaggedButton),
        for: .touchUpInside)
    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtontab()
    }
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        
        delegate?.didTapTaggeduttonTab()
       }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constans.padding * 2)
        let girdButtonX = ((width/2)-size)/2
        
        gridButton.frame = CGRect(
            x: girdButtonX,
            y: Constans.padding,
            width: size,
            height: size)
        taggedButton.frame = CGRect(
            x: girdButtonX + (width/2),
            y: Constans.padding,
            width: size,
            height: size)
    }
}
