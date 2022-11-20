//
//  TopMovieViewModel.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import Foundation
import Alamofire
import RxSwift

final class TopMovieViewModel {
    private let usecase: TopMovieUsecase 
    
    init(usecase: TopMovieUsecase) {
        self.usecase = usecase
    }
    
    var movieDataSource: Observable<[MovieData]> {
        return self.usecase.movies
            .map { movie in
                return movie.map { MovieData(movie: $0)}
            }
    }
}

extension TopMovieViewModel {
    func requestMovies() {
        self.usecase.requestMovies()
    }
    
    func loadMoreMovies() {
        self.usecase.loadMoreMovies()
    }
    
    func getMovieAtIndex(index: Int) -> Movie {
        return self.usecase.getMovieAtIndex(index: index)
    }
    
    func setLikedAtIndex(index: Int, isLiked: Bool) {
        self.usecase.setLikedAtIndex(index: index, isLiked: isLiked)
    }
}
