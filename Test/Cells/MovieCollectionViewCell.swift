//
//  ColorCollectionViewCell.swift
//  Test
//
//  Created by 이선재 on 2022/10/24.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    override var reuseIdentifier: String? {
        return "MovieCollectionViewCell"
    }
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        applyDesign()
        setupPosterImageView()
        setupTitleLabel()
        setupRatingLabel()
    }
    
    func configure(movieData: MovieData) {
        self.posterImageView.sd_setImage(with: URL(string: movieData.posterUrlString), completed: nil)
        self.titleLabel.text = movieData.title
        self.ratingLabel.text = "⭐️ \(movieData.vote_average)"
    }
    
    private func applyDesign() {
        self.contentView.backgroundColor = .lightGray
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.isOpaque = true
    }
    
    private func setupPosterImageView() {
        self.posterImageView.layer.cornerRadius = 8
        self.posterImageView.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(self.posterImageView)
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 150)
        ])
    }
    
    private func setupTitleLabel() {
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.titleLabel.textColor = .black
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .center
        self.titleLabel.adjustsFontSizeToFitWidth = true
        
        self.contentView.addSubview(self.titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 30)
        ])
    }
    
    private func setupRatingLabel() {
        self.ratingLabel.font = .systemFont(ofSize: 15)
        self.ratingLabel.textColor = .black
        self.ratingLabel.lineBreakMode = .byWordWrapping
        self.ratingLabel.numberOfLines = 1
        self.ratingLabel.textAlignment = .center
        
        self.contentView.addSubview(self.ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            ratingLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            ratingLabel.bottomAnchor.constraint(equalTo: self.ratingLabel.topAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
