//
//  SearchedRecipe.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 14.08.2025.
//

import Foundation

struct SearchedData: Codable {
    let results: [SearchedRecipe]
    let totalResults: Int?
}

struct SearchedRecipe: Codable {
    let id: Int
    let title: String
    let image: String
}
