//
//  RecipDetailFavoriteViewController.swift
//  Reciplease
//
//  Created by AMIMOBILE on 13/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import SafariServices

class RecipDetailFavoriteViewController: UIViewController {
   
    // MARK: - vars, lets
    var recipsList = [RecipEntity]()
    var recipDetailFavoriteSelected: RecipEntity?
    var ingredientLinesFavoriteSelected = [String]()
    
    @IBOutlet weak var recipDetailFavoriteTableView: UITableView!
    @IBOutlet weak var recipDetailFavoriteImageView: GradientImageView!
    @IBOutlet weak var recipDetailFavoriteNameLabel: UILabel!
    @IBOutlet weak var recipDetailFavoriteLikeLabel: UILabel!
    @IBOutlet weak var recipDetailFavoriteDurationLabel: UILabel!
    
    @IBOutlet weak var recipCommentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getIngredientLines()
        update()
        setRightButtonItem()
        recipComment()
    }
    
    // MARK: - Outlet actions
    @IBAction func addRecipCommentButton() {
        alertAddComment()
        commentButton.isHidden = true
        recipCommentLabel.isHidden = false
    }
    
    @IBAction func getDirectionButton() {
        let urlString = recipDetailFavoriteSelected?.source
        guard let url = URL(string: urlString ?? "") else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    // MARK: - Methods
    func recipComment() {
        if checkRecipHadComment() {
            commentButton.isHidden = true
            recipCommentLabel.text = recipDetailFavoriteSelected?.comment
        } else {
            recipCommentLabel.isHidden = true
        }
    }
    
    private func alertAddComment() {
        let alert = UIAlertController(title: nil, message: "Add Your Comment", preferredStyle: .alert)
        alert.addTextField { (textFieldTask) in
            textFieldTask.placeholder = "Please add comment"
        }
        
        let saveAdd = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = alert.textFields?.first, let comment = textField.text else { return }
            self.recipDetailFavoriteSelected?.setValue(comment, forKey: "comment")
            try? AppDelegate.viewContext.save()
            self.recipCommentLabel.text = RecipEntity.getRecipselectedInData(id: self.recipDetailFavoriteSelected?.id ?? "").first?.comment
        }
        alert.addAction(saveAdd)
        present(alert, animated: true)
    }
    
    private func checkRecipHadComment() -> Bool {
        if recipDetailFavoriteSelected?.comment != nil {
            return true
        } else {
            return false
        }
    }
    
    private func setRightButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
            navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    private func getIngredientLines() {
        if let recipDetailFavoriteSelected = recipDetailFavoriteSelected, let ingredientLineEntities = recipDetailFavoriteSelected.ingredientlines?.allObjects as? [IngredientLineEntity] {
            ingredientLinesFavoriteSelected = ingredientLineEntities.map({ $0.name ?? "" })
                } else {
                presentAlert(message: "No Ingredient Lines available")
            }
    }
  
    private func update() {
        recipDetailFavoriteNameLabel.text = recipDetailFavoriteSelected?.name
        recipDetailFavoriteLikeLabel.text = recipDetailFavoriteSelected?.like
        recipDetailFavoriteDurationLabel.text = recipDetailFavoriteSelected?.duration
        if let imageData = recipDetailFavoriteSelected?.imageDetail, let image = UIImage(data: imageData) {
            recipDetailFavoriteImageView.image = image
        } else {
            let image = UIImage(named: "imagerecipdefault")
            recipDetailFavoriteImageView.image = image
        }
    }
    
    @objc private func favoriteButtonTapped() {
        guard let id = recipDetailFavoriteSelected?.id else {
            presentAlert(message: "Can't delete this recip in the Favorite")
            return
        }
            RecipEntity.deleteRecipSelected(id: id)
            presentAlert(message: "This recips has been deleted in the Favorite")
        }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension UITableView
extension RecipDetailFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLinesFavoriteSelected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = recipDetailFavoriteTableView.dequeueReusableCell(withIdentifier: "IngresDetailFavoriteCell", for: indexPath)
        cell.textLabel?.text = ingredientLinesFavoriteSelected[indexPath.row].stringToFirstCapitalLetter
        return cell
    }
}
