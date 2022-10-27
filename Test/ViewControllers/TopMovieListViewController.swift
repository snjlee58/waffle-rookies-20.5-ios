//
//  TopMovieListViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import UIKit
import RxSwift
import RxCocoa

class TopMovieListViewController: UIViewController {
    let disposeBag = DisposeBag()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MoviesCollectionViewFlowLayout())
    var page = 1

    let viewModel: TopMovieViewModel
    let movieViewModelObserver = PublishRelay<[Movie]>()
    
    let favoritesViewModel: FavoritesViewModel
    
    init(viewModel: TopMovieViewModel, favoritesViewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies(pagination: false, page: self.page)
        
        // NotificationCenter addObserver
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(starDiaryNotification(_:)),
                                               name: NSNotification.Name("starDiary"),
                                               object: nil)
        
        // collectionView
        bindCollectionView()
        self.view.addSubview(collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        self.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        

    }
    
    private func bindCollectionView() {
        self.movieViewModelObserver
            .bind(to: collectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)) { (index: Int, movie: Movie, cell: MovieCollectionViewCell) in
                cell.configure(movie: movie)
            }.disposed(by: disposeBag)
    }
    
    func configureUI() {
        self.title = "Movies"
        self.view.backgroundColor = .white
    }
    
    func fetchMovies(pagination: Bool, page: Int) {
        self.viewModel.fetchMovies(pagination: pagination, page: page).subscribe(onNext: { movieListObservable in
            self.movieViewModelObserver.accept(movieListObservable)
        })
    }
    
    @objc func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let id = starDiary["id"] as? Int else { return }
        guard let index = self.viewModel.results.firstIndex(where: { $0.id == id }) else { return }
        
        // Update isLiked in movieList
        self.viewModel.results[index].isLiked = isStar
        
        // Add to favoritesList if Liked
        if (isStar) {
            if !self.favoritesViewModel.isInFavorites(movie: self.viewModel.results[index]) {
                self.favoritesViewModel.favoritesList.append(self.viewModel.results[index])
            }
        } else {
            self.favoritesViewModel.favoritesList.removeAll { $0.id == self.viewModel.results[index].id }
        }
    }
}

extension TopMovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.favoritesViewModel.isInFavorites(movie: self.viewModel.results[indexPath.row]) {
            self.viewModel.results[indexPath.row].isLiked = true
        }
        
        let movie = self.viewModel.results[indexPath.row]
        let movieDetailVC = MovieDetailViewController(movie: movie)
        
        self.parent?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(movieDetailVC, animated: true)
        self.parent?.hidesBottomBarWhenPushed = false
    }
}

extension TopMovieListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > self.collectionView.contentSize.height-100-scrollView.frame.size.height) {
            guard (!self.viewModel.isPaginating) else { return }
            
            page = page + 1
            fetchMovies(pagination: true, page: page)
        }
    }
}
