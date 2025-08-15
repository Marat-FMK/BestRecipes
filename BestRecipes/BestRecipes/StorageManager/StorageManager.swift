//
//  StorageManager.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 14.08.2025.
//

import Foundation

enum WorldCuisines: String, CaseIterable {
    case american = "American"
    case european = "European"
    case greek = "Greek"
    case japanese = "Japanese"
    case mexican = "Mexican"
    case african = "African"
}

enum MealType: String, CaseIterable {
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case soup = "soup"
    case snack = "snack"
    case drink = "drink"
    case sideDish = "side dish"
    case bread = "bread"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
}


class StorageManager {
    let networkManager = NetworkManager()
    
    let cuisineNames = WorldCuisines.allCases.map{ String($0.rawValue) } // массив кухонь мира для главного экрана
    let categories = MealType.allCases.map{ String($0.rawValue) } // массив категорий для главного экрана
    
    let currentCategory = MealType.appetizer // текущая/выбранная категория
    
    var trendingRecipesAll: [RecipeDetail] = []
    var trendingRecipes: [RecipeDetail] {
        var intermediateArray: [RecipeDetail] = []
        if !trendingRecipesAll.isEmpty {
            let recipesCount = trendingRecipesAll.count
            if recipesCount > 5 {
                for index in 0..<5 {
                    intermediateArray.append(trendingRecipesAll[index])
                }
            } else {
                for index in 0..<recipesCount {
                    intermediateArray.append(trendingRecipesAll[index])
                }
            }
        }
        return intermediateArray
    }
    
    var categoryRecipesAll: [RecipeDetail] = []
    var categoryRecipes: [RecipeDetail] {
        var intermediateArray: [RecipeDetail] = []
        if !categoryRecipesAll.isEmpty {
            let recipesCount = categoryRecipesAll.count
            if recipesCount > 5 {
                for index in 0..<5 {
                    intermediateArray.append(categoryRecipesAll[index])
                }
            } else {
                for index in 0..<recipesCount {
                    intermediateArray.append(categoryRecipesAll[index])
                }
            }
        }
        return intermediateArray
    }
    
    
    var searchedRecipes: [RecipeDetail] = []
    
//    var recentRecipesID: [Int] = [] // собирает индесы и сохраняем что бы загрузить при старте
    var recentRecipes: [RecipeDetail] = [] // сохраняет массив просмотренных
    var favoriteRecipes: [RecipeDetail] = []
    
    var recentRecipesIDs: [Int] {
        var intermediate: [Int] = []
        if !recentRecipes.isEmpty {
            for recipe in recentRecipes {
                intermediate.append(recipe.id)
            }
        }
        return intermediate
    }
    
    var favoriteRecipesIDs: [Int] = []
    
    
    //MARK: - METHODS
    
    func setCategotyRecipes(category: MealType) {
        var recipesID: [Int] = []
        
        networkManager.fetchRecipes(mealType: category, maxRecipeCount: "10") { result in
            switch result {
            case .success(let searchedRecipes):
                for recipe in searchedRecipes {
                    recipesID.append(recipe.id)
                }
                self.networkManager.fetchReceptsDetails(ids: recipesID) { result in
                    switch result {
                    case .success(let recipes):
                        self.categoryRecipesAll = recipes
                    case .failure(let error):
                        print("❌ error storage categories")
                    }
                }
            case .failure(let error):
                print("alarm category")
            }
        }
    }
    
    
    //MARK: - Recent and Favorite
    func saveRecentRecepie(recipe: RecipeDetail) { // при каждом открытии окна детального просмотра
        recentRecipes.insert(recipe, at: 0)
    }
    
    func saveFavoriteRecipe(recipe: RecipeDetail) { // при нажатии кнопки сохраниения в избранное
        if !favoriteRecipesIDs.contains(recipe.id) {
            favoriteRecipes.append(recipe)
            favoriteRecipesIDs.append(recipe.id)
        }
    }
    
    func deleteFavoriteRecipe(recipe: RecipeDetail) {
        if favoriteRecipesIDs.contains(recipe.id) {
            if let index = favoriteRecipesIDs.firstIndex(of: recipe.id){
                favoriteRecipes.remove(at: index)
                favoriteRecipesIDs.remove(at: index)
            }
        }
    }
    
    
    
}
