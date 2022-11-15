//
//  TabBarViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let favoritesViewModel: FavoritesViewModel
    
    init(favoritesViewModel: FavoritesViewModel) {
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureTabs()
        applyDesign()
    }
    
    private func configureTabs() {
        let moviesRootVC = UINavigationController(rootViewController: MovieTabViewController(favoritesViewModel: self.favoritesViewModel))
        moviesRootVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let favoritesRootVC = UINavigationController(rootViewController: FavoritesTabViewController(viewModel: self.favoritesViewModel))
        favoritesRootVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        
        setViewControllers([moviesRootVC, favoritesRootVC], animated: true)
    }
    
    private func applyDesign() {
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .black
    }
}
