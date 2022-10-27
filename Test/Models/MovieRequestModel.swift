//
//  MovieRequestModel.swift
//  Test
//
//  Created by 이선재 on 2022/10/16.
//

import Foundation

struct MovieRequestModel: Codable {
    let api_key: String = "1033ea3a4a3db6c8fa6461493c074b8b"
    let page: Int

    init(page: Int) {
        self.page = page
    }
}
