//
//  MovieTabViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import UIKit

class MovieTabViewController: UIViewController {
    let filterSegControl = UISegmentedControl(items: ["Popular", "Top Rated"])
    
    let popularMovieVC: PopularMovieListViewController
    let topMovieVC: TopMovieListViewController
    
    init(favoritesViewModel: FavoritesViewModel) {
        self.popularMovieVC = PopularMovieListViewController(viewModel: PopularMovieViewModel(), favoritesViewModel: favoritesViewModel)
        self.topMovieVC = TopMovieListViewController(viewModel: TopMovieViewModel(), favoritesViewModel: favoritesViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        // Configure general UI
        self.title = "Movies"
        
        // Configure segmentedControl
        self.view.addSubview(self.filterSegControl)
        self.filterSegControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.filterSegControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.filterSegControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.filterSegControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.filterSegControl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        filterSegControl.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
              self.filterSegControl.selectedSegmentIndex = 0
              

        addChild(popularMovieVC)
        self.view.addSubview(popularMovieVC.view)
        popularMovieVC.didMove(toParent: self)
        popularMovieVC.view.frame.origin.y = 150

        addChild(topMovieVC)
        self.view.addSubview(topMovieVC.view)
        topMovieVC.didMove(toParent: self)
        topMovieVC.view.frame.origin.y = 150
        
        topMovieVC.view.isHidden = true
    }
    
    @objc func didTapSegment(segment: UISegmentedControl) {
        self.popularMovieVC.view.isHidden = true
        self.topMovieVC.view.isHidden = true
        
        if segment.selectedSegmentIndex == 0 {
            self.popularMovieVC.view.isHidden = false
        } else {
            self.topMovieVC.view.isHidden = false
        }
        
    }

}

