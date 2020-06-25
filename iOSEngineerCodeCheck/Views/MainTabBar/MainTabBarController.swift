//
//  MainTabBarController.swift
//  iOSEngineerCodeCheck
//
//  Created by jun on 2020/06/25.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let serchGitHubRepVC = SearchGitHubRepositoriesViewBuilder.create()
        serchGitHubRepVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let serchGitHubRepVCNavigationController = UINavigationController(rootViewController: serchGitHubRepVC)
        
        let favoriteRepositoriesVC = FavoriteRepositoriesViewBuilder.create()
        favoriteRepositoriesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites , tag: 1)
        let favoriteRepositoriesVCNavigationController = UINavigationController(rootViewController: favoriteRepositoriesVC)
        
        self.tabBar.tintColor = .systemPink
        self.viewControllers = [serchGitHubRepVCNavigationController, favoriteRepositoriesVCNavigationController]
    }
}
