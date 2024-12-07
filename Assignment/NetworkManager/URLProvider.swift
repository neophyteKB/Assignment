//
//  URLProvider.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation

public struct URLProvider {
    private let baseURL: String = "https://newsdata.io/api/1/news"
    
    func generateURL(categories: [NewsCategory], search: String?) throws -> URL {
        var components = URLComponents(string: baseURL)
        
        var queryItems: [URLQueryItem] = [
            (URLQueryItem(name: "apikey", value: apiKey)),
            (URLQueryItem(name: "language", value: "en"))
        ]
        
        if !categories.isEmpty {
            let categoryQuery = categories.map(\.query).joined(separator: ",")
            queryItems.append(URLQueryItem(name: "category", value: categoryQuery))
        }
        
        if let search, !search.isEmpty {
            queryItems.append(URLQueryItem(name: "q", value: search))
        }
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        return url
    }
}

// API Key
// TODO: Move api_key to secrets
private let apiKey = "pub_61210a2d792dd97341143f956e5a0fd4adc3e"
