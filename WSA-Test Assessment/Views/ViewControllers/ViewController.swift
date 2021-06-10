//
//  ViewController.swift
//  WSA-Test Assessment
//
//  Created by ali on 6/10/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Pet Food"
        self.selectedIndex = 0
        setupTabBarImages()
    }
    
    func setupTabBarImages() {
        if let tabBarItems = self.tabBar.items {
            if tabBarItems.indices.contains(0) {
                tabBarItems[0].image = UIImage(named: "home")!.withRenderingMode(.alwaysTemplate)
                tabBarItems[0].selectedImage = UIImage(named: "home")!.withRenderingMode(.alwaysOriginal)
            }
            
            if tabBarItems.indices.contains(1) {
                tabBarItems[1].image = UIImage(named: "profile")!.withRenderingMode(.alwaysOriginal)
                tabBarItems[1].selectedImage = UIImage(named: "profile")!.withRenderingMode(.alwaysTemplate)
            }
            
            if tabBarItems.indices.contains(2) {
                tabBarItems[2].image = UIImage(named: "search")!.withRenderingMode(.alwaysOriginal)
                tabBarItems[2].selectedImage = UIImage(named: "search")!.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
}

