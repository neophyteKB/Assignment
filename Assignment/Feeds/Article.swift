//
//  Article.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Foundation

struct FeedResponse: Decodable, Sendable {
    let status: String
    let results: [Article]
}

struct Article: Decodable, Sendable {
    var articleId: String
    let title: String
    let link: String
    let videoUrl: String?
    let description: String?
    let content: String
    let pubDate: String
    let pubDateTZ: String
    let imageUrl: String?
    let sourceId: String
    let sourceName: String
    let sourceUrl: String
    let sourceIcon: String?
    let language: String
}

public enum NewsCategory: String, Codable, Sendable {
    case none
    case sports
    case top
    case business
    case domestic
    
    var query: String {
        rawValue
    }
    
    var name: String {
        rawValue.capitalized
    }
}
