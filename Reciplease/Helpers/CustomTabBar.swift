//
//  CustomTabBar.swift
//  Reciplease
//
//  Created by AMIMOBILE on 24/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Font
        let font = UIFont(name: "SnellRoundhand", size: 30.0)!
        let fontAttributes = [NSAttributedString.Key.font: font]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        // Add Color
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.lightGray
        
        // Add line for Tab Bar
        let topLine = CALayer()
        topLine.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1)
        topLine.backgroundColor = UIColor.white.cgColor
        tabBar.layer.addSublayer(topLine)
    
        // Add separator line for Tab Bar
        let separatorLine = CALayer()
        separatorLine.frame = CGRect(x: tabBar.frame.width/2, y: 0, width: 1, height: tabBar.frame.height)
        separatorLine.backgroundColor = UIColor.white.cgColor
        tabBar.layer.addSublayer(separatorLine)
    }
}
    
