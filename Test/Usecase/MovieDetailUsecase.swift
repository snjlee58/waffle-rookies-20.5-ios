//
//  MovieDetailUsecase.swift
//  Test
//
//  Created by 이선재 on 2022/11/16.
//

import Foundation
//import Alamofire
//import RxCocoa
//import RxSwift

final class MovieDetailUsecase {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func setLikedStatus(isLiked: Bool) {
        self.movie.isLiked = isLiked
    }
}
