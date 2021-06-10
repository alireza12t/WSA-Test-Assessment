//
//  FoodTableViewCell.swift
//  WSA-Test Assessment
//
//  Created by ali on 6/10/21.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodBrandNameLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foodImageView.layer.borderWidth = 1
        foodImageView.layer.borderColor = UIColor.black.cgColor
        foodImageView.layer.cornerRadius = 12
        fetchIamge(with: "")
    }
    
    func fetchIamge(with imageUrl: String) {
        if imageUrl.isEmpty {
            setEmptyImage()
        } else {
            if let url = URL(string: "https://foodpets.madskill.ru/up/images/\(imageUrl)") {
                foodImageView.kf.setImage(with: url, placeholder: UIImage(named: "image")!) { [weak self] (result) in
                    guard let self = self else { return }
                    switch result {
                    case .success(_ ):
                        self.foodImageView.contentMode = .scaleAspectFill
                        self.foodImageView.backgroundColor = .clear
                    case .failure(_ ):
                        self.setEmptyImage()
                    }
                }
            } else {
                setEmptyImage()
            }
        }
    }
    
    func setEmptyImage() {
        foodImageView.contentMode = .center
        foodImageView.backgroundColor = .imageBlue
        foodImageView.image = UIImage(named: "image")!
    }
    
    func fillCell(with foodData: FoodData) {
        self.fetchIamge(with: foodData.image)
        self.foodBrandNameLabel.text = foodData.BrandName
        self.foodNameLabel.text = foodData.FoodName
        if let price = Int(foodData.price) {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            self.foodPriceLabel.text = (formatter.string(from: NSNumber(integerLiteral: price)) ?? "0.00") + " $"
        } else {
            self.foodPriceLabel.text = foodData.price + " $"
        }
    }
}
