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
    private let disposeBag = DisposeBag()

    private let viewModel: MovieDetailViewModel

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private var starButton = UIBarButtonItem()
    private let overviewTextView = UITextView()
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = UIView()
        configure()
        applyDesign()
        setupLayout()
    }
    
    private func setupLayout() {
        setupLikeButton()
        setupPosterImageView()
        setupTitleLabel()
        setupRatingLabel()
        setupOverviewTextView()
    }
    
    private func setupLikeButton() {
        self.starButton.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
    }
    
    private func setupPosterImageView() {
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
    }
    
    private func setupTitleLabel() {
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
    }
    
    private func setupRatingLabel() {
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
    }
    
    private func setupOverviewTextView() {
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
    
    private func applyDesign() {
        self.view.backgroundColor = .white
    }
    
    private func configure() {
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton.image = self.viewModel.movie.isLiked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        let urlString = "https://image.tmdb.org/t/p/original\(self.viewModel.movie.poster_path)"
        self.posterImageView.sd_setImage(with: URL(string: urlString), completed: nil)
        
        self.titleLabel.text = self.viewModel.movie.title
        self.ratingLabel.text = "⭐️ \(self.viewModel.movie.vote_average)"
        self.overviewTextView.text = self.viewModel.movie.overview
    }
    
    @objc func tapStarButton() {
        let isStar = self.viewModel.movie.isLiked

        if isStar {
            self.starButton.image = UIImage(systemName: "star")
        } else {
            self.starButton.image = UIImage(systemName: "star.fill")
        }
        
        self.viewModel.setLikedStatus(isLiked: !isStar)
        
        // NotificationCenter (update isLiked)
        NotificationCenter.default.post(name: NSNotification.Name("isLikedNotificationMovie"),
                                        object: [
                                            "movie": self.viewModel.movie,
                                        ],
                                        userInfo: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
