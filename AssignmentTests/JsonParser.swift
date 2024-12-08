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
            let data = try Data(contentsOf: URL(filePath: file), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(FeedResponse.self, from: data)
            if case .array(let feeds) = response.results {
                return feeds
            }
            return []
        } catch {
            return []
        }
    }
}
