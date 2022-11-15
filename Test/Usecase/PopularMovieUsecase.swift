//
//  PopularMovieUsecase.swift
//  Test
//
//  Created by 이선재 on 2022/11/14.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

final class PopularMovieUsecase {
    private let repository: PopularMovieRepository
    private let disposeBag = DisposeBag()
    private var page: Int = 1
    
    var movieList = [Movie]() {
        didSet {
            self.popularMovieSubject.accept(self.movieList)
        }
    }

    private let popularMovieSubject: BehaviorRelay<[Movie]> = .init(value: [])
    
    var movies: Observable<[Movie]> {
        return self.popularMovieSubject.asObservable()
    }

    init(repository: PopularMovieRepository) {
        self.repository = repository
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isLikedNotification(_:)),
                                               name: NSNotification.Name("isLikedNotificationMovie"),
                                               object: nil)
    }
    
    @objc func isLikedNotification(_ notification: Notification) {
        guard let isLikedNotificationMovie = notification.object as? [String: Any] else { return }
        guard let movie = isLikedNotificationMovie["movie"] as? Movie else { return }
        guard let index = self.movieList.firstIndex(where: { $0.id == movie.id }) else { return }
        
        // Update isLiked in movieList
        self.movieList[index].isLiked = movie.isLiked
    }

    func requestMovies() {
        let parameters = MovieRequestModel(page: self.page)

        self.repository
            .requestMovies(parameters: parameters)
            .subscribe(onSuccess: { [weak self] fetchedMovies in
                self?.movieList = fetchedMovies
            },
            onFailure: { _ in
                self.movieList = []
            })
            .disposed(by: self.disposeBag)
    }
    
    func loadMoreMovies() {
        self.page += 1
        let parameters = MovieRequestModel(page: self.page)
        
        self.repository
            .requestMovies(parameters: parameters)
            .subscribe(onSuccess: { [weak self] fetchedMovies in
                var prevMovies = self?.popularMovieSubject.value ?? []
                prevMovies.append(contentsOf: fetchedMovies)
                self?.movieList = prevMovies
            },
            onFailure: { _ in
                self.movieList = []
            })
            .disposed(by: self.disposeBag)
    }
    
    func getMovieAtIndex(index: Int) -> Movie {
        return self.movieList[index]
    }
    
    func setLikedAtIndex(index: Int, isLiked: Bool) {
        self.movieList[index].isLiked = isLiked
    }
}


final class PopularMovieRepository {
    func requestMovies(parameters: MovieRequestModel) -> Single<[Movie]> {
        return Single.create { single in
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular")

            let headers: HTTPHeaders = [
                "Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDMzZWEzYTRhM2RiNmM4ZmE2NDYxNDkzYzA3NGI4YiIsInN1YiI6IjYzNDI1OTY0YTI4NGViMDA3OWM0MTYxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eV0F9zBLPdjef9gth_012Q3We_jiY_bjLRyuaqS9DkI"
            ]

            AF.request(url!, method: .get, parameters: parameters, headers: headers)
                .responseDecodable(of: MovieModel.self) { [weak self] response in
                    switch response.result {
                    case .success(let result):
                        single(.success(result.results))
                    case .failure(let _):
                        single(.success([]))
                    }
                }

            return Disposables.create()
        }
    }
}
