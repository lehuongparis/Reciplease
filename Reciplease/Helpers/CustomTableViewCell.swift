//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by AMIMOBILE on 02/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        customCell()
    }

        private func customCell() {
            self.backgroundColor = UIColor.darkGray
            self.textLabel?.textColor = UIColor.white
            self.textLabel?.font = UIFont(name: "SnellRoundhand", size: 25)
        }

}
