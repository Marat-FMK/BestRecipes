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
    let sourceUrl: String
    let spoonacularScore: Double
    let instructions: String
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let readyInMinutes: Int
    let extendedIngredients: [ExtendedIngredient]
    let sourceName: String
    let vegetarian: Bool
    let glutenFree: Bool
    let servings: Int
    
}

struct ExtendedIngredient: Codable {
    let name: String
    let consistency: String
    let amount: Double
    let unit: String
}
