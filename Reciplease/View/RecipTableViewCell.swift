//
//  RecipTableViewCell.swift
//  Reciplease
//
//  Created by AMIMOBILE on 23/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class RecipTableViewCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // make backgroundColor of whiteWiew is always gray when cell selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        whiteView.backgroundColor = UIColor.gray
    }

    @IBOutlet weak var recipsImageView: UIImageView!
    @IBOutlet weak var recipNameLabel: UILabel!
    @IBOutlet weak var ingresLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(image: UIImage, name: String, ingredients: String, temp: String, like: String) {
        recipsImageView.image = image
        recipNameLabel.text = name
        ingresLabel.text = ingredients
        tempLabel.text = temp
        likeLabel.text = like + "k"
    }
}

