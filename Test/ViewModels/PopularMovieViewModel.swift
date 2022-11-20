//
//  PopularMovieViewModel.swift
//  Test
//
//  Created by 이선재 on 2022/10/25.
//

import Foundation
import Alamofire
import RxSwift

final class PopularMovieViewModel {
    private let usecase: PopularMovieUsecase
    
    init(usecase: PopularMovieUsecase) {
        self.usecase = usecase
    }
    
    var movieDataSource: Observable<[MovieData]> {
        return self.usecase.movies
            .map { movie in
                return movie.map { MovieData(movie: $0)}
            }
    }
}

extension PopularMovieViewModel {
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

struct MovieData {
    let title: String
    let poster_path: String
    let vote_average: Float
    let overview: String
    var isLiked: Bool
    let id: Int
    let posterUrlString: String
    
    init(movie: Movie) {
        self.title = movie.title
        self.poster_path = movie.poster_path
        self.vote_average = movie.vote_average
        self.overview = movie.overview
        self.isLiked = movie.isLiked
        self.id = movie.id
        self.posterUrlString = "https://image.tmdb.org/t/p/original\(self.poster_path)"
    }
}
