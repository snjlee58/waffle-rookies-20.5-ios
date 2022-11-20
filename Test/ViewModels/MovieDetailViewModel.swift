//
//  MovieDetailViewModel.swift
//  Test
//
//  Created by 이선재 on 2022/11/15.
//

import Foundation

class MovieDetailViewModel {
    let usecase: MovieDetailUsecase
    
    var movie: Movie {
        return self.usecase.movie
    }
    
    init(usecase: MovieDetailUsecase) {
        self.usecase = usecase
    }
    
    func setLikedStatus(isLiked: Bool) {
        self.usecase.setLikedStatus(isLiked: isLiked)
    
    }
}
