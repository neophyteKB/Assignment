//
//  NewsCategory.swift
//  Assignment
//
//  Created by Kamal Kishor on 07/12/24.
//

import Foundation

public enum NewsCategory: String, CaseIterable, Sendable {
    case business
    case crime
    case domestic
    case education
    case entertainment
    case food
    case health
    case lifestyle
    case politics
    case science
    case sports
    case technology
    case tourism
    case world
    
    var query: String {
        rawValue
    }
    
    var name: String {
        rawValue.capitalized
    }
}
