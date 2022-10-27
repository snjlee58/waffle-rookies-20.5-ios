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
    let disposeBag = DisposeBag()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: MoviesCollectionViewFlowLayout())
    
    let favoritesViewModel: FavoritesViewModel
    let favoritesViewModelObserver = PublishRelay<[Movie]>()
    
    init(favoritesViewModel: FavoritesViewModel) {
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindCollectionView()
        self.configureCollectionView()
        self.title = "Favorites"
        self.favoritesViewModel.loadFavoritesList()
//        print("run")
        
        // NotificationCenter addObserver (update isLiked)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(starDiaryNotification(_:)),
                                               name: NSNotification.Name("starDiary"),
                                               object: nil)
        
        // NotificationCenter addObserver (update FavoritesTabList)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(favoritesTabNotification(_:)),
                                               name: NSNotification.Name("favoritesTab"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bindCollectionView() {
        self.favoritesViewModel.favoriteListObservable
            .bind(to: self.collectionView.rx.items(cellIdentifier: "MovieCollectionViewCell", cellType: MovieCollectionViewCell.self)) { (index: Int, movie: Movie, cell: MovieCollectionViewCell) in
                cell.configure(movie: movie)
            }.disposed(by: disposeBag)
    }
    
    private func configureCollectionView() {
        // Configure collectionView
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
    
    @objc func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
//        guard let uuidString = starDiary["uuidString"] as? String else { return }
        guard let id = starDiary["id"] as? Int else { return }
        guard let index = self.favoritesViewModel.favoritesList.firstIndex(where: { $0.id == id }) else { return }
        
        // Update isLiked in movieList
        self.favoritesViewModel.favoritesList[index].isLiked = isStar
    }
    
    @objc func favoritesTabNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let id = starDiary["id"] as? Int else { return }
        guard let index = self.favoritesViewModel.favoritesList.firstIndex(where: { $0.id == id }) else { return }
        
        self.favoritesViewModel.favoritesList[index].isLiked = isStar
        if (!isStar) {
            self.favoritesViewModel.favoritesList.remove(at: index)
        }
    }
}

extension FavoritesTabViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let movie = self.favoritesViewModel.favoritesList[indexPath.row]
            let movieDetailVC = MovieDetailViewController(movie: movie)

        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(movieDetailVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
}
