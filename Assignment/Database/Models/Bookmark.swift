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
    var desc: String
    var content: String
    
    init(article: Article) {
        self.id = article.articleId
        self.title = article.title
        self.desc = article.description ?? ""
        self.content = article.content
    }
}
