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
    
    var recipFavorite: RecipEntity! {
        didSet {
            recipFavoriteNameLabel.text = recipFavorite.name
            let ingredientEntities = recipFavorite.ingredient?.allObjects as? [IngredientEntity]
            recipFavoriteIngresLabel.text = ingredientEntities?.map({ $0.name ?? ""
            }).joined(separator: ", ").stringToFirstCapitalLetter
            recipFavoriteLikeLabel.text = recipFavorite.like
            recipFavoriteDurationLabel.text = recipFavorite.duration
            if let imageData = recipFavorite.image {
                recipFavaoriteImageView.image = UIImage(data: imageData)
            } else {
                recipFavaoriteImageView.image = UIImage(named: "imagerecipdefault")
            }
        }
    }
}
