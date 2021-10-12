//
//  TabBarViewController.swift
//  Dance Journal
//
//  Created by João Pedro Picolo on 11/10/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets ups other view controllers
        let vc1 = HomeViewController()
        let vc2 = HomeViewController()
        let vc3 = HomeViewController()
        
        // Sets up navigation bar
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
      
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Sequences", image: UIImage(systemName: "hands.sparkles"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        self.tabBar.tintColor = UIColor(named: "tabColor")
        self.tabBar.barTintColor = UIColor(named: "tabBackgroundColor")

        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
}
