//
//  TabBarViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let favoritesViewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
        // Tab 1 (Movies tab)
        let moviesRootVC = UINavigationController(rootViewController: MovieTabViewController(favoritesViewModel: self.favoritesViewModel))
        moviesRootVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
//        // Tab 2 (Favorites Tab)
        let favoritesRootVC = UINavigationController(rootViewController: FavoritesTabViewController(favoritesViewModel: self.favoritesViewModel))
        favoritesRootVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
//
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .black
        setViewControllers([moviesRootVC, favoritesRootVC], animated: true)
    }

}
