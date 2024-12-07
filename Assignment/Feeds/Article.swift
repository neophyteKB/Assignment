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

extension String {
    func dateString(for timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: timezone)
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "dd MMM yyyy"
            return formatter.string(from: date)
        }
        else {
            if let dateString = self.components(separatedBy: " ").first {
                return dateString + " " + "(\(timezone))"
            }
            else {
                return "Unknown Date"
            }
        }
    }
}
