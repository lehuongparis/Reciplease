//
//  CustomButton.swift
//  Reciplease
//
//  Created by AMIMOBILE on 01/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = UIColor.green
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
