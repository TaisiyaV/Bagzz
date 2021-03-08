//
//  TabBarController.swift
//  Bagzz
//
//  Created by tasya on 02.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {

    
    var tabBarHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewTabBar = UIView(frame: .zero)
        viewTabBar.backgroundColor = .white
        viewTabBar.layer.cornerRadius = 32
        viewTabBar.layer.shadowColor = UIColor.black.cgColor
        viewTabBar.layer.shadowOffset = CGSize(width: 0.5, height: 4.0)
        viewTabBar.layer.shadowOpacity = 0.1
        viewTabBar.layer.shadowRadius = 5.0
        tabBar.addSubview(viewTabBar)
        
        viewTabBar.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview().inset(11)
            m.top.equalToSuperview()
            m.height.equalTo(65)
        }
        

        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .black

        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.barTintColor = .clear
        tabBar.isTranslucent = true
        
        tabBarHeight = tabBar.frame.height + 20
      
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabFrame = self.tabBar.frame
        guard let window = UIApplication.shared.keyWindow else { return }
        tabFrame.size.height = tabBarHeight + window.safeAreaInsets.bottom
        self.tabBar.frame = tabFrame
        
        tabBar.items?[0].image = UIImage(named: "home")
        tabBar.items?[1].image = UIImage(named: "search")
        tabBar.items?[2].image = UIImage(named: "heart")
        tabBar.items?[3].image = UIImage(named: "cart")
        
     
    }
    
    



}



