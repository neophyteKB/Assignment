//
//  JsonParser.swift
//  Assignment
//
//  Created by Kamal Kishor on 03/12/24.
//

import Foundation

struct JsonParser {
    static var feeds: [Article] {
        guard let file = Bundle.main.path(forResource: "FeedsJson", ofType: "json") else {
            return []
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: file, options: .prettyPrinted)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let feeds = try decoder.decode([Article].self, from: data)
            return feeds
        } catch {
            return []
        }
    }
}
