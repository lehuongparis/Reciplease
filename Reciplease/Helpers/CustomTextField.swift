//
//  TextField.swift
//  Reciplease
//
//  Created by AMIMOBILE on 02/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func layoutSubviews() {
       addLine()
    }
    
    // MARK : - Add line in the TextField
    private func addLine() {
        let border = CALayer()
        let lineWidth = CGFloat(0.3)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.placeholder = "Sugar, Cheese, Oil..."
    }
}
