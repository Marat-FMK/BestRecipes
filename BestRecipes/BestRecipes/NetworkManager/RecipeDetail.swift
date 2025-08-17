//
//  RecipeDetail.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 14.08.2025.
//

import Foundation

struct RecipeDetail: Codable {
    let id: Int
    let title: String
    let image: String
    let spoonacularScore: Double
    let instructions: String
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let readyInMinutes: Int
    let extendedIngredients: [ExtendedIngredient]
    let sourceName: String
    let sourceUrl: String
    let vegetarian: Bool
    let glutenFree: Bool
    let servings: Int
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case id, title, image, spoonacularScore, instructions,
                 preparationMinutes, cookingMinutes, readyInMinutes,
                 extendedIngredients, sourceName, sourceUrl, vegetarian,
                 glutenFree, servings
        }
}

struct ExtendedIngredient: Codable {
    let name: String
    let amount: Double
    let unit: String
    let consistency: String
    let image: String
    
    
}
