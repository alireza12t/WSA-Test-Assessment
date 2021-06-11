//
//  HomeViewController.swift
//  WSA-Test Assessment
//
//  Created by ali on 6/10/21.
//

import UIKit

enum Animaltype: String {
    case Cats, Dogs
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    @IBAction func typeSegmentedCoontrolValueDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.type = .Cats
        case 1:
            self.type = .Dogs
        default:
            self.type = .Dogs
        }
        fetchFoods()
    }
    
    var foods: [FoodData] = []
    var type: Animaltype = .Dogs
    
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
        segmentedControl.layer.borderColor = UIColor.black.cgColor
        segmentedControl.layer.borderWidth = 0.5
        segmentedControl.layer.cornerRadius = 6
        segmentedControl.layer.masksToBounds = true
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.textColor
        ], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.selectedTextColor
        ], for: .selected)
        
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = .primaryBlue
        } else {
            segmentedControl.tintColor = .primaryBlue
        }
    }
    
    func fetchFoods() {
        foods = []
        tableView.reloadData()
        guard let url = URL(string: "https://foodpets.madskill.ru/food?filter=\(type.rawValue.lowercased())") else {
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
                    self.typeSegmentedControl.setTitle("\(self.type.rawValue) (\(self.foods.count))", forSegmentAt: self.typeSegmentedControl.selectedSegmentIndex)
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
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
