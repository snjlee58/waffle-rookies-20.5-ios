//
//  MoviesCollectionViewFlowLayout.swift
//  Test
//
//  Created by 이선재 on 2022/10/15.
//

import UIKit

class MoviesCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        self.sectionInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        self.minimumLineSpacing = 5
        self.minimumInteritemSpacing = 5
        self.scrollDirection = .vertical
       
        let cellWidth = (UIScreen.main.bounds.width - 15) / 2.0 // Subtract minimumInteritemSpacing and Inset
        self.itemSize = CGSize(width: cellWidth, height: 220.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
