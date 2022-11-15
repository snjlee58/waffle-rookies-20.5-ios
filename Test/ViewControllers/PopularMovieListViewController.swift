//
//  ViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/15.
//

import UIKit
import RxSwift
import RxCocoa

class PopularMovieListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MoviesCollectionViewFlowLayout())

    private let viewModel: PopularMovieViewModel
    private let favoritesViewModel: FavoritesViewModel
    
    init(viewModel: PopularMovieViewModel, favoritesViewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        self.viewModel.requestMovies()
        
        applyDesign()
        bindCollectionView()
        setupCollectionView()
    }
    
    private func bindCollectionView() {
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.viewModel.movieDataSource
            .bind(to: self.collectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)) { index, movieData, cell in
                cell.configure(movieData: movieData)
            }.disposed(by: self.disposeBag)
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    func applyDesign() {
        self.view.backgroundColor = .white
    }
}

extension PopularMovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie = self.viewModel.getMovieAtIndex(index: indexPath.row)
        
        if (self.favoritesViewModel.isInFavorites(movie: movie)) {
            self.viewModel.setLikedAtIndex(index: indexPath.row, isLiked: true)
            movie = self.viewModel.getMovieAtIndex(index: indexPath.row)
        }
        
        let movieDetailUsecase = MovieDetailUsecase(movie: movie)
        let movieDetailVM = MovieDetailViewModel(usecase: movieDetailUsecase)
        let movieDetailVC = MovieDetailViewController(viewModel: movieDetailVM)
        
        self.parent?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(movieDetailVC, animated: true)
        self.parent?.hidesBottomBarWhenPushed = false
    }
}

extension PopularMovieListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > self.collectionView.contentSize.height-scrollView.frame.size.height) {
            self.viewModel.loadMoreMovies()
        }
    }
}
