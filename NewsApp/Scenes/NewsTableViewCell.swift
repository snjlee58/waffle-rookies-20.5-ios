 //
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by 이선재 on 2022/09/28.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return "NewsTableViewCell"
    }
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsTableViewCell")
        
        // Task Label
        self.titleLabel.font = .systemFont(ofSize: 15)
        self.titleLabel.textColor = .black
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
        
        self.contentView.addSubview(self.titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -170),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        //Date Label
        self.dateLabel.textColor = .black
        self.dateLabel.font = .systemFont(ofSize: 15)
        
        self.contentView.addSubview(self.dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 30),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(item: News) {
        // Convert title text from html to String
        self.titleLabel.text = item.title.htmlToString
        
        // Change format of pubDate
        let origDateStr = item.pubDate
        let origDateFormatter = DateFormatter()
        origDateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        origDateFormatter.locale = Locale(identifier: "en_US")
        let origDateObj: Date = origDateFormatter.date(from: origDateStr)!
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.locale = Locale(identifier: "ko_KR")
        myDateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let formattedDateStr = myDateFormatter.string(from: origDateObj)
        self.dateLabel.text = formattedDateStr
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

