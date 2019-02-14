//
//  RecipFavoriteViewController.swift
//  Reciplease
//
//  Created by AMIMOBILE on 13/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class RecipFavoriteViewController: UIViewController {

    var recipFavorite = [RecipData]()
    var recipFavoriteSelected: RecipData?

    @IBOutlet weak var recipFavoriteTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(deleteFavorite))

        recipFavorite = RecipData.all
        recipFavoriteTableView.reloadData()
        recipFavoriteTableView.tableFooterView = UIView()
    }
    
    @objc private func deleteFavorite() {
        RecipData.deleteAll()
        recipFavorite = RecipData.all
        recipFavoriteTableView.reloadData()
    }
}

extension RecipFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipFavorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipFavoriteCell", for: indexPath) as? RecipFavoriteTableViewCell else { return UITableViewCell() }
        updateCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.activityIndicator.isHidden = false
        recipFavoriteSelected = RecipData.all[indexPath.row]
        print(recipFavoriteSelected!)
        performSegue(withIdentifier: "segueToRecipDetailFavorite", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.gray
        label.text = "No recips in your Favorite"
        label.font = UIFont(name: "SnellRoundhand", size: 35)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return recipFavorite.isEmpty ? 800 : 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipDetailFavorite" {
            let detailFavoriteVC = segue.destination as! RecipDetailFavoriteViewController
            detailFavoriteVC.recipDetailFavoriteSelected = recipFavoriteSelected
        }
    }
    private func updateCell(cell: RecipFavoriteTableViewCell, indexPath: IndexPath) {
        
        let name = recipFavorite[indexPath.row].name ?? ""
        let ingredients = recipFavorite[indexPath.row].ingredients?.stringToFirstCapitalLetter ?? ""
        let temp = recipFavorite[indexPath.row].duration ?? ""
        let like = recipFavorite[indexPath.row].like ?? ""
        if let imageData = recipFavorite[indexPath.row].image?.stringImagetoDataImage, let image = UIImage(data: imageData) {
            cell.configure(image: image, name: name, ingredients: ingredients, temp: temp, like: like)
        } else {
            let image = UIImage(named: "imagerecipdefault")
            cell.configure(image: image!, name: name, ingredients: ingredients, temp: temp, like: like)
        }
    }
}

