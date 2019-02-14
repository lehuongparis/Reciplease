//
//  ViewController.swift
//  Reciplease
//
//  Created by AMIMOBILE on 03/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class SearchViewController: UIViewController {    
    
    private let recipService = RecipService()
    
    var ingredients: [String] = []
    var allowedIngreString = ""
    var recipsList = [Match]()
    
    @IBOutlet weak var ingreTextField: UITextField!
    @IBOutlet weak var ingreTableView: UITableView!
    @IBOutlet weak var ingresTextLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingreTableView.reloadData()
        ingreTableView.tableFooterView = UIView()
        activityIndicatorView.isHidden = true
    }
    
    @IBAction func searchButton() {
        if ingredients != [] {
            activityIndicatorView.isHidden = false
            getRecips()
        } else {
            presentAlert()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecip" {
            let recipVC = segue.destination as! RecipViewController
            recipVC.recipsList = recipsList
        }
    }
    
    private func createAllowedIngre(){
                for ingredient in ingredients {
                    allowedIngreString += "&allowedIngredient[]=" + ingredient
                }
            }

    private func getRecips() {
        recipService.getRecips(allowedIngreString: allowedIngreString) { (success, recipsData) in
            if success {
                guard let recips = recipsData else { return }
                self.recipsList = recips.matches
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToRecip", sender: self)
                    self.activityIndicatorView.isHidden = true
                    }
                }
            }
        }
    
    @IBAction func addIngreButton() {
        guard let namesString = ingreTextField.text  else { return }
            ingredients = namesString.stringToArrayString
            ingreTableView.reloadData()
    }
    
    @IBAction func resetButton() {
        ingredients = []
        ingreTableView.reloadData()
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Error", message: "Please add your ingredients", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ingreTableView.dequeueReusableCell(withIdentifier: "IngresCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        
        cell.textLabel?.text = "- " + ingredient.stringToFirstCapitalLetter
        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingreTextField.resignFirstResponder()
        return true
    }
}

