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
        if let statusCode = (response as? HTTPURLResponse)?.statusCode,
            !(200...299).contains(statusCode) {
            let error = NetworkError.responseError
            throw error
        }
        return try await parse(data: data)
    }
    
    private func parse(data: Data) async throws -> [Article] {
        let feedResponse = try jsonDecoder.decode(FeedResponse.self, from: data)
        switch feedResponse.results {
        case .array(let articles): return articles
        case .dictionary(let dict):
            let error = NetworkError.serverError(code: dict["code"], message: dict["message"])
            throw error
        }
    }
}

enum NetworkError: Error {
    case badUrl
    case dataCorruptedError
    case responseError
    case serverError(code: String?, message: String?)
    
    var message: String {
        switch self {
        case .responseError: return "Bad response"
        case .badUrl: return "Bad URL"
        case .dataCorruptedError: return "Data corrupted"
        case .serverError(let code, let message):
            var errorMessage: String = ""
            if let code {
                errorMessage = code
                errorMessage += "/n"
            }
            if let message {
                errorMessage += message
            }
            return errorMessage
        }
    }
}
