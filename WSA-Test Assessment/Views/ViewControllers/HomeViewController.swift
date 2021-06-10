//
//  HomeViewController.swift
//  WSA-Test Assessment
//
//  Created by ali on 6/10/21.
//

import UIKit

enum Animaltype: String {
    case cats, dogs
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    var foods: [FoodData] = []
    var type: Animaltype = .dogs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFoods()
    }
    
    @IBAction func typeSegmentedCoontrolValueDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.type = .cats
        case 1:
            self.type = .dogs
        default:
            self.type = .dogs
        }
        fetchFoods()
    }
    
    func fetchFoods() {
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if foods.indices.contains(indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
            let cellData = foods[indexPath.row]
            cell.fillCell(with: cellData)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
