//
//  MovieDetailViewController.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var movie: Movie
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let ratingLabel = UILabel()
    var starButton = UIBarButtonItem()
    let overviewTextView = UITextView()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = UIView()
        configure()
        applyDesign()
        setupLayout()
    }
    
    private func setupLayout() {
        // starButton
        self.starButton.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
        
        // posterImageView
        self.posterImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(self.posterImageView)
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            self.posterImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.posterImageView.topAnchor, constant: 200),
        ])
        
        // titleLabel
        self.titleLabel.textAlignment = .center
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.titleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 10),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 30)
        ])
        
        // ratingLabel
        self.view.addSubview(self.ratingLabel)
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.ratingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            self.ratingLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            self.ratingLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.ratingLabel.bottomAnchor.constraint(equalTo: self.ratingLabel.topAnchor, constant: 30)
        ])
        self.ratingLabel.textAlignment = .center
        
        // overviewTextView
        self.overviewTextView.font = .systemFont(ofSize: 12)
        self.overviewTextView.isSelectable = false
        
        self.view.addSubview(self.overviewTextView)
        self.overviewTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.overviewTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.overviewTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            self.overviewTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.overviewTextView.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 10),
            self.overviewTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func configure() {
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton.image = self.movie.isLiked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        let urlString = "https://image.tmdb.org/t/p/original\(movie.poster_path)"
        self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        
        self.titleLabel.text = self.movie.title
        self.ratingLabel.text = "⭐️ \(self.movie.vote_average)"
        self.overviewTextView.text = self.movie.overview

    }
    
    @objc func tapStarButton() {
        let isStar = self.movie.isLiked
        
        if isStar {
            self.starButton.image = UIImage(systemName: "star")
        } else {
            self.starButton.image = UIImage(systemName: "star.fill")
        }
        
        self.movie.isLiked = !isStar
        
        // NotificationCenter (update isLiked)
        NotificationCenter.default.post(name: NSNotification.Name("starDiary"),
                                        object: [
                                            "isStar": self.movie.isLiked ?? false,
                                            "id": self.movie.id
                                        ],
                                        userInfo: nil)
    }
    
    private func applyDesign() {
        self.view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            // NotificationCenter (update Favorites Tab)
            NotificationCenter.default.post(name: NSNotification.Name("favoritesTab"),
                                            object: [
                                                "isStar": self.movie.isLiked ?? false,
//                                                "uuidString": self.movie.uuidString,
                                                "id": self.movie.id
                                            ],
                                            userInfo: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
