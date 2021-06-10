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
    
    var foods: [FoodData] = []
    var type: Animaltype = .dogs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        configureSegmentedControl(segmentedControl: self.typeSegmentedControl, selectedIndex: 1)
        fetchFoods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFoods()
    }
    
    
    
    func configureSegmentedControl(segmentedControl: UISegmentedControl, selectedIndex: Int) {
        segmentedControl.selectedSegmentIndex = selectedIndex
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ], for: .selected)
        
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = .primaryBlue
        } else {
            segmentedControl.tintColor = .primaryBlue
        }
    }
    
    func fetchFoods() {
        guard let url = URL(string: "https://foodpets.madskill.ru/food?filter=\(type.rawValue)") else {
            print("URL is not valid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Request Failed")
                return
            }
            do {
                let foodData = try JSONDecoder().decode([FoodData].self, from: data)
                DispatchQueue.main.async {
                    self.foods = foodData
                    self.tableView.reloadData()
                }
            } catch let error {
                print("\(error)")
            }
        }.resume()
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
