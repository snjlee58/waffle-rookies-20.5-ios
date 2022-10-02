//
//  APICaller.swift
//  NewsApp
//
//  Created by 이선재 on 2022/09/24.
//

// Client ID/secret를 header에 입력한다.
// Client ID: sY6hwukTQ4wAva1M36Un
// Client Secret: i2XWs4t8aK

import Foundation



struct A: Codable {
    let source: Source
    let title: String
    let description: String
    let url: String
}

struct Source: Codable {
    let name: String
}
