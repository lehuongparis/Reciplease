//
//  RecipViewController.swift
//  Reciplease
//
//  Created by AMIMOBILE on 22/01/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import UIKit

class RecipViewController: UIViewController {
    
    // MARK: - vars, lets
    private let recipService = RecipService()
    var recip: Match?
    var recipsList = [Match]()
    var recipDetailList = [RecipDetail]()

    @IBOutlet weak var recipsTableView: UITableView!    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipsTableView.reloadData()
        recipsTableView.tableFooterView = UIView()
        activityIndicator.isHidden = true
    }
}

// MARK: - Extension UITableView
extension RecipViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < recipsList.count else { fatalError("Index out of range") }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipCell", for: indexPath) as? RecipTableViewCell else {
                return UITableViewCell()
                }
        cell.recip = recipsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.activityIndicator.isHidden = false
        recip = self.recipsList[indexPath.row]
        let id = self.recipsList[indexPath.row].id
        getRecipsDetail(id: id)
    }
    
    private func getRecipsDetail(id: String) {
        recipService.getRecipDetail(id: id) { (success, recipDetailData) in
            if success {
                guard let recipDetail = recipDetailData else { return }
                self.recipDetailList = [recipDetail]

                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToDetail", sender: self)
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let detailVC = segue.destination as! RecipDetailViewController
            detailVC.recipDetailList = recipDetailList
            detailVC.recip = recip
        }
    }
}



    




