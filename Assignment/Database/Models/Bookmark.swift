//
//  Bookmark.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Foundation
import SwiftData

@Model
final class Bookmark {
    var id: String
    var title: String
    var link: String
    var videoUrl: String?
    var desc: String?
    var content: String
    var pubDate: String
    var pubDateTZ: String
    var imageUrl: String?
    var sourceId: String
    var sourceName: String
    var sourceUrl: String
    var sourceIcon: String?
    var language: String
    
    init(article: Article) {
        self.id = article.articleId
        self.title = article.title
        self.link = article.link
        self.videoUrl = article.videoUrl
        self.desc = article.description ?? ""
        self.content = article.content
        self.pubDate = article.pubDate
        self.pubDateTZ = article.pubDateTZ
        self.imageUrl = article.imageUrl
        self.sourceId = article.sourceId
        self.sourceName = article.sourceName
        self.sourceUrl = article.sourceUrl
        self.sourceIcon = article.sourceIcon
        self.language = article.language
    }
}
