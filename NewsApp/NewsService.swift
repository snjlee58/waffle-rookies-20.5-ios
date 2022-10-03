//
//  NewsService.swift
//  NewsApp
//
//  Created by 이선재 on 2022/09/25.
//

import Foundation

struct NewsService {
    static let shared = NewsService()
    
    let clientID = "sY6hwukTQ4wAva1M36Un"
    let clientSecret = "i2XWs4t8aK"
    
    var url = "https://openapi.naver.com/v1/search/news"
}
