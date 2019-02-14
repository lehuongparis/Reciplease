//
//  TextLabel.swift
//  Reciplease
//
//  Created by AMIMOBILE on 30/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class TextLabel: UILabel {
    
    override func layoutSubviews() {
        addDots()
    }
    
    private func addDots() {
        self.lineBreakMode = .byTruncatingTail
    }
}
