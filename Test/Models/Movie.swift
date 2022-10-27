//
//  Movie.swift
//  Test
//
//  Created by 이선재 on 2022/10/16.
//

import Foundation
import RxCocoa
import RxSwift

struct Movie: Codable {
//    let uuidString: String
    let title: String
    let poster_path: String
    let vote_average: Float
    let overview: String
    var isLiked: Bool
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case title, poster_path, vote_average, overview, id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
        poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path) ?? "-"
        vote_average = try container.decodeIfPresent(Float.self, forKey: .vote_average) ?? 0.0
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? "-"
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0

        isLiked = false
//        uuidString = UUID().uuidString
    }
    
    init(
        title: String,
        poster_path: String,
        vote_average: Float,
        overview: String,
        isLiked: Bool = false,
//        uuidString: String,
        id: Int
        
    ) {
        self.title = title
        self.poster_path = poster_path
        self.vote_average = vote_average
        self.overview = overview
        self.isLiked = isLiked
//        self.uuidString = uuidString
        self.id = id
    }
}
