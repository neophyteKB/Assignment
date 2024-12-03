//
//  NetworkManager.swift
//  Assignment
//
//  Created by Kamal Kishor on 02/12/24.
//
import Foundation
import Combine

final class NetworkManager {
    func fetchArticles() async -> [Article] {
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=YOUR_API_KEY"
        guard let url = URL(string: urlString) else { return [] }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Article].self, from: data)
        } catch {
            print("Error fetching articles: \(error)")
            return []
        }
    }
}

