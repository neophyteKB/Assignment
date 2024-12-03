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
    var id: UUID
    var title: String
    var summary: String
    var content: String
    var category: String
    
    init(article: Article) {
        self.id = article.id
        self.title = article.title
        self.summary = article.summary
        self.content = article.content
        self.category = article.category
    }
}
