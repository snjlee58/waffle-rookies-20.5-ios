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
    var favoritesList = [Movie]() {
        didSet {
            self.saveMovieList()
            self.acceptObserver()
        }
    }
    
    var favoriteListObserver = PublishRelay<[Movie]>()
    var favoriteListObservable: Observable<[Movie]> {
        return favoriteListObserver.asObservable()
    }

    func acceptObserver() {
        self.favoriteListObserver.accept(self.favoritesList)
    }
    
    private func saveMovieList() {
        let data = self.favoritesList.map {
            [
                "title": $0.title,
                "poster_path": $0.poster_path,
                "vote_average": $0.vote_average,
                "overview": $0.overview,
                "isLiked": $0.isLiked,
                "id": $0.id
            ]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey:  "favoriteMovies")
    }
    
    func loadFavoritesList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "favoriteMovies") as? [[String: Any]] else { return }

        self.favoritesList = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let poster_path = $0["poster_path"] as? String else { return nil }
            guard let vote_average = $0["vote_average"] as? Float else { return nil }
            guard let overview = $0["overview"] as? String else { return nil }
            guard let isLiked = $0["isLiked"] as? Bool else { return nil }
            guard let id = $0["id"] as? Int else { return nil }
            return Movie(title: title, poster_path: poster_path, vote_average: vote_average, overview: overview, isLiked: isLiked, id: id)
        }.filter({
            $0.isLiked == true
        })
        
    }
    
    func isInFavorites(movie: Movie) -> Bool {
        let isInFavorites = self.favoritesList.contains(where: { $0.id == movie.id })
        return isInFavorites
    }
}
