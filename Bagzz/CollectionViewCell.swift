//
//  CollectionViewCell.swift
//  Bagzz
//
//  Created by tasya on 02.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bags1")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        
        image.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.width.equalTo(351.0)
            m.height.equalTo(195.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
