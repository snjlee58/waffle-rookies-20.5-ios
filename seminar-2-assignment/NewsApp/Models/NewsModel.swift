//
//  NewsResponseModel.swift
//  NewsApp
//
//  Created by 이선재 on 2022/09/25.
//

import Foundation
import Alamofire

class NewsModel: Decodable {
    var items: [News] = []
    
    func request(
        from keyword: String,
        start: Int = 1,
        display: Int = 20,
        sort: String = "sim",
        completionHandler: @escaping () -> Void) {
            guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return }

            let parameters = NewsRequestModel(start: start, display: display, query: keyword, sort: sort)
            let headers: HTTPHeaders = [
                "X-Naver-Client-Id": "sY6hwukTQ4wAva1M36Un",
                "X-Naver-Client-Secret": "i2XWs4t8aK"
            ]

            AF.request(url, method: .get, parameters: parameters, headers: headers)
                    .responseDecodable(of: NewsModel.self) { response in
                        switch response.result {
                        case .success(let result):
                            self.items = result.items
                            completionHandler()
                        case .failure(let error):
                            self.items = []
                            completionHandler()
                        }
                    }
                    .resume()
        }
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
