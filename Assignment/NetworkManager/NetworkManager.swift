//
//  NetworkManager.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation

final class NetworkManager {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchArticles(categories: [NewsCategory] = [], query: String? = nil) async throws -> [Article] {
        let urlProvider = URLProvider()
        let url = try urlProvider.generateURL(categories: categories, search: query)
        let (data, response) = try await URLSession.shared.data(from: url)
        if (response as? HTTPURLResponse)?.statusCode != 200 {
            let error = NetworkError.response(response: response)
            throw error
        }
        let feedResponse = try jsonDecoder.decode(FeedResponse.self, from: data)
        if feedResponse.status == "success" {
            return feedResponse.results
        }
        return [] // TODO: handle error case
    }
}

enum NetworkError: Error {
    case response(response: URLResponse?)
}
