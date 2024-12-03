//
//  Article.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//

import Foundation

struct Article: Identifiable, Decodable, Sendable {
    var id: UUID = UUID()
    let title: String
    let summary: String
    let content: String
    let category: String
}
