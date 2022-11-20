//
//  FavoritesUsecase.swift
//  Test
//
//  Created by 이선재 on 2022/11/15.
//

import Foundation
import RxCocoa
import RxSwift

class FavoritesUsecase {
    var favoritesList = [Movie]() {
        didSet {
            self.saveMovieList()
            self.acceptObserver()
        }
    }
    
    var favoriteListObserver: BehaviorRelay<[Movie]> = .init(value: [])
    
    var movies: Observable<[Movie]> {
        return favoriteListObserver.asObservable()
    }
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isLikedNotification(_:)),
                                               name: NSNotification.Name("isLikedNotificationMovie"),
                                               object: nil)
    }
    
    @objc func isLikedNotification(_ notification: Notification) {
        guard let isLikedNotificationMovie = notification.object as? [String: Any] else { return }
        guard let movie = isLikedNotificationMovie["movie"] as? Movie else { return }
        
        if (movie.isLiked) {
            if !self.isInFavorites(movie: movie) { // Add to favoritesList if not already in it
                self.addToFavorites(movie: movie)
            }
        } else {
            self.removeFromFavorites(movie: movie)
        }
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
    
    func getMovieAtIndex(index: Int) -> Movie {
        return self.favoritesList[index]
    }
    
    func addToFavorites(movie: Movie) {
        self.favoritesList.append(movie)
    }
    
    func removeFromFavorites(movie: Movie) {
        self.favoritesList.removeAll { $0.id == movie.id }
    }
}

