//
//  FavoritesTabViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesTabViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MoviesCollectionViewFlowLayout())
    
    private let viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.loadMovies()
        
        self.bindCollectionView()
        self.setupCollectionView()
        
        self.title = "Favorites"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bindCollectionView() {
        self.viewModel.movieDataSource
            .bind(to: self.collectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)) { index, movieData, cell in
                cell.configure(movieData: movieData)
            }.disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        self.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension FavoritesTabViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel.getMovieAtIndex(index: indexPath.row)
        
        let movieDetailUsecase = MovieDetailUsecase(movie: movie)
        let movieDetailVM = MovieDetailViewModel(usecase: movieDetailUsecase)
        let movieDetailVC = MovieDetailViewController(viewModel: movieDetailVM)

        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(movieDetailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
