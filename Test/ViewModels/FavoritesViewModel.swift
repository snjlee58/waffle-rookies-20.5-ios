//
//  FavoritesViewModel.swift
//  Test
//
//  Created by 이선재 on 2022/10/26.
//

import Foundation
import RxCocoa
import RxSwift

class FavoritesViewModel {
    private let usecase: FavoritesUsecase
    
    init(usecase: FavoritesUsecase) {
        self.usecase = usecase
    }
    
    var movieDataSource: Observable<[MovieData]> {
        return self.usecase.movies
            .map { movie in
                return movie.map { MovieData(movie: $0)}
            }
    }
}

extension FavoritesViewModel {
    func loadMovies() {
        self.usecase.loadFavoritesList()
    }
    
    func isInFavorites(movie: Movie) -> Bool {
        return self.usecase.isInFavorites(movie: movie)
    }
    
    func getMovieAtIndex(index: Int) -> Movie {
        return self.usecase.getMovieAtIndex(index: index)
    }
    
    func addToFavorites(movie: Movie) {
        self.usecase.addToFavorites(movie: movie)
    }
    
    func removeFromFavorites(movie: Movie) {
        self.usecase.removeFromFavorites(movie: movie)
    }
}
