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
    
    var recip: Match! {
        didSet {
            recipNameLabel.text = recip.recipeName
            ingresLabel.text = recip.ingredients.joined(separator: ", ").stringToFirstCapitalLetter
            likeLabel.text = String(recip.rating) + "k"
            tempLabel.text = recip.totalTimeInSeconds.timeInHoursandMinutes
            if let imageData = recip.smallImageUrls[0].stringImagetoDataImage, let image = UIImage(data: imageData) {
                recipsImageView.image = image
            } else {
                recipsImageView.image = UIImage(named: "imagerecipdefault")
            }
        }
    }
}

