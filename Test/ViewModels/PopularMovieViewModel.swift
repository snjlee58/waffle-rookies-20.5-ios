//
//  PopularMovieViewModel.swift
//  Test
//
//  Created by 이선재 on 2022/10/25.
//

import Foundation
import Alamofire
import RxSwift

class PopularMovieViewModel: Decodable {
    var isPaginating = false
    var results = [Movie]()
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        results = try container.decodeIfPresent([Movie].self, forKey: .results) ?? [Movie]()

        isPaginating = false
    }
    
    init(){
        
    }
    
    func fetchMovies(pagination: Bool, page: Int) -> Observable<[Movie]> {
        isPaginating = true
        return Observable.create { (observer) -> Disposable in
            
            self.request(pagination: pagination, page: page) { (error, movies) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let movies = movies {
                    self.results.append(contentsOf: movies)
                    observer.onNext(self.results)
                }
                
                if self.isPaginating {
                    self.isPaginating = false
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func request(pagination: Bool, page: Int, completionHandler: @escaping (Error?, [Movie]?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular") else { return }

        let parameters = MovieRequestModel(page: page)
        
            let headers: HTTPHeaders = [
                "Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDMzZWEzYTRhM2RiNmM4ZmE2NDYxNDkzYzA3NGI4YiIsInN1YiI6IjYzNDI1OTY0YTI4NGViMDA3OWM0MTYxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eV0F9zBLPdjef9gth_012Q3We_jiY_bjLRyuaqS9DkI"
            ]

            AF.request(url, method: .get, parameters: parameters, headers: headers)
                    .responseDecodable(of: PopularMovieViewModel.self) { response in
                        switch response.result {
                        case .success(let result):
                            completionHandler(nil, result.results)
                        case .failure(let error):
                            print(error)
                            completionHandler(error, nil)
                        }
                    }
                    .resume()
        }
    
    
}

