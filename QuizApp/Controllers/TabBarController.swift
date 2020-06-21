//
//  TabBarController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 19/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var viewConotroller1 : QuizListController?
    var viewConotroller2 : SearchScreenController?
    var viewConotroller3 : SettingsScreenController?
    var subviewControllers : [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConotroller1 = QuizListController()
        viewConotroller2 = SearchScreenController()
        viewConotroller3 = SettingsScreenController()
        
        subviewControllers.append(viewConotroller1!)
        subviewControllers.append(viewConotroller2!)
        subviewControllers.append(viewConotroller3!)
        
        viewConotroller1?.tabBarItem = UITabBarItem(title: "List", image: #imageLiteral(resourceName: "lista@1"), tag: 0)
        viewConotroller2?.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), tag: 1)
        viewConotroller3?.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), tag: 2)
        
        self.setViewControllers(subviewControllers, animated: true)
        self.selectedIndex = 0
        self.selectedViewController = viewConotroller1
        self.tabBar.tintColor = .red
          
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            print("tab 1")
            tabBar.tintColor = .red
        case 1:
            print("tab 2")
            self.tabBar.tintColor = .green
        case 2:
            print("tab 3")
            self.tabBar.tintColor = .blue
        default:
            print("no tab")
        }
    }

}
