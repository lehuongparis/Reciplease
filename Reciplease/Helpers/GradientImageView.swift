//
//  GradientImageView.swift
//  Reciplease
//
//  Created by AMIMOBILE on 30/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {
    
    // Add grandient Layer for ImageView
    func addGrandient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGrandient()
    }
}



