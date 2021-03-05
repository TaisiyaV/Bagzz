//
//  CollectionViewCell2.swift
//  Bagzz
//
//  Created by tasya on 02.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {
    
    var image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "image1")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textAlignment = .center
        l.text = "Artsy"
        l.textColor = .black
        return l
    }()
    
    let shopButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "shopNow"), for: .normal)
        return b
    }()
    
    let likeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart1")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        addSubview(titleLabel)
        addSubview(shopButton)
        addSubview(likeImage)
        
        
        image.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(6)
            m.left.equalToSuperview().inset(31)
            m.right.equalToSuperview().inset(28)
            m.width.height.equalTo(111)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(image.snp.bottom).inset(-11)
            m.left.right.equalToSuperview().inset(30)
            m.height.equalTo(24)
        }
        
        shopButton.snp.makeConstraints { (m) in
            m.top.equalTo(titleLabel.snp.bottom).inset(-18)
            m.left.right.equalToSuperview().inset(41)
            m.height.equalTo(22)
            m.width.equalTo(88)
        }
        
        likeImage.snp.makeConstraints { (m) in
            m.top.equalToSuperview().inset(6)
            m.right.equalToSuperview().inset(9)
            m.height.equalTo(12.57)
            m.width.equalTo(16)
        }
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
