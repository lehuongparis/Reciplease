//
//  RecipFavoriteTableViewCell.swift
//  Reciplease
//
//  Created by AMIMOBILE on 13/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class RecipFavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var recipFavoriteNameLabel: UILabel!
    @IBOutlet weak var recipFavoriteIngresLabel: UILabel!
    @IBOutlet weak var recipFavoriteLikeLabel: UILabel!
    @IBOutlet weak var recipFavoriteDurationLabel: UILabel!
    
    @IBOutlet weak var recipFavaoriteImageView: GradientImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        whiteView.backgroundColor = UIColor.gray
    }
    
    func configure(image: UIImage, name: String, ingredients: String, temp: String, like: String) {
        recipFavaoriteImageView.image = image
        recipFavoriteNameLabel.text = name
        recipFavoriteIngresLabel.text = ingredients
        recipFavoriteDurationLabel.text = temp
        recipFavoriteLikeLabel.text = like + "k"
    }

}
