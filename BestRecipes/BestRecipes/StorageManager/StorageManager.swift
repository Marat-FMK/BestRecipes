//
//  StorageManager.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 14.08.2025.
//

import Foundation


enum Direction: String {
    case trending = "trending"
    case category = "category"
    case search = "search"
    case cuisines = "cuisines"
}

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
    private let networkManager = NetworkManager()
    
    let cuisineNames = WorldCuisines.allCases.map{ String($0.rawValue) } // массив кухонь мира для главного экрана
    let categories = MealType.allCases.map{ String($0.rawValue) } // массив категорий для главного экрана
    
    var currentCategory: MealType {
        let uDCategory = UserDefaults.standard.string(forKey: Constants.UDConstants.currentCategory) // сюда сохраняем выбранную на HomeView категорию в UD
        
        switch uDCategory {
        case "dessert": return .dessert
        case "appetizer": return .appetizer
        case "salad": return .salad
        case "soup": return .soup
        case "snack": return .snack
        case "drink": return .drink
        case "sideDish": return .sideDish
        case "bread": return .bread
        case "beverage": return .beverage
        case "sauce": return .sauce
        case "marinade": return .marinade
        case "fingerfood": return .fingerfood
        default: return .bread
        }
    }
    
    var searchText = "" // при изменении искомого слова - передаем его в этот паараметр и вызываем ф-ию setSearchRecipes
    
    var searchedRecipes: [RecipeDetail] = [] // массив наполняется после вызова ф-ии setSearchRecipes
    
    var choosedCuisine = WorldCuisines.american // выбранная страна
    var currentCuisineRecipes: [RecipeDetail] = [] // массив наполняется после вызова ф-ии setCurrentCuisineRecipes
    
    var favoriteRecipes: [RecipeDetail] = [] // массив избранных
    var favoriteRecipesIDs: [Int] = []
    
    var trendingRecipesAll: [RecipeDetail] = [] // все рецепты которые загружаются при старте
    var trendingRecipes: [RecipeDetail] { // отдает только 5 рецептов для показа на Home view
        setArrayForHomeView(allRecipes: trendingRecipesAll)
    }
    
    var categoryRecipesAll: [RecipeDetail] = [] // все рецепты которые загружаются при выборе очередной категории
    var categoryRecipes: [RecipeDetail] { // отдает только 5 рецептов для показа на Home view
        setArrayForHomeView(allRecipes: categoryRecipesAll)
    }
    
    var recentRecipes: [RecipeDetail] = [] // сохраняет массив просмотренных исупользую ф-ию saveRecentRecepie
    var recentRecipesIDs: [Int] { // нужен для проверки перед добавлением нового просмотренного что бы не дублироваться
        var intermediate: [Int] = []
        if !recentRecipes.isEmpty {
            for recipe in recentRecipes {
                intermediate.append(recipe.id)
            }
        }
        return intermediate
    }
    
    // Метод собирает массив из 5 или менее элементов для HomeView
    private func setArrayForHomeView(allRecipes: [RecipeDetail]) -> [RecipeDetail] {
        var intermediateArray: [RecipeDetail] = []
        if !allRecipes.isEmpty {
            let recipesCount = allRecipes.count
            if recipesCount > 5 {
                for index in 0..<5 {
                    intermediateArray.append(allRecipes[index])
                }
            } else {
                for index in 0..<recipesCount {
                    intermediateArray.append(allRecipes[index])
                }
            }
        }
        return intermediateArray
    }
    
    //MARK: - METHODS FOR CREATING ARRAYS OF RECIPE DETAILS WITH API
    //Cобирает результат выполнения поиска и извлекает ID нужных рецептов, потом бежит в сеть собирает все детальные рецепты // Раскидывает все по нужным массивам
    private func setArrayOfRecipeDetails(direction: Direction, result: Result<[SearchedRecipe],NetworkError>) {
        var recipesID: [Int] = []
        switch result {
        case .success(let searchedRecipes):
            for recipe in searchedRecipes {
                recipesID.append(recipe.id)
            }
            print("✅ \(direction.rawValue) Recipes ids -->>", recipesID)
            self.networkManager.fetchReceptsDetails(ids: recipesID) { result in
                
                switch result {
                case .success(let recipes):
                    switch direction {
                    case .trending:
                        self.trendingRecipesAll = recipes
                    case .category:
                        self.categoryRecipesAll = recipes
                    case .search:
                        self.searchedRecipes = recipes
                    case .cuisines:
                        self.currentCuisineRecipes = recipes
                    }
                    
                    print("✅ \(direction.rawValue) Recipes -->>", recipes)
                case .failure(let error):
                    print("❌ error storage \(direction.rawValue) recipes detail", error)
                }
            }
        case .failure(let error):
            print("❌ error storage \(direction.rawValue) recipes ids array", error)
        }
    }
    
    
    //Ф-ия вызывается при каждом нажатии на кнопку выбора категории - собирает массив categoryRecipesAll // После чего можно будет использовать геттер categoryRecipes который берет из этого массива только 5 элементов для показа на главном экране // А весь массив показывается только на See All экране
    func setCategotyRecipes() {
        networkManager.fetchRecipes(mealType: currentCategory) { result in
            self.setArrayOfRecipeDetails(direction: .category, result: result)
        }
    }
    
    func setTrendingRecipes() {
        networkManager.fetchRecipes(trend: true) { result in
            self.setArrayOfRecipeDetails(direction: .trending, result: result)
        }
    }
    
    func setSearchRecipes() {
        networkManager.fetchRecipes(searchedText: searchText) { result in // добавить параметр максимального кол-ва рецептов в ф-ию при необходимости
            self.setArrayOfRecipeDetails(direction: .search, result: result)
        }
    }
    
    func setCurrentCuisineRecipes() {
        networkManager.fetchRecipes(cuisine: choosedCuisine) { result in
            self.setArrayOfRecipeDetails(direction: .cuisines, result: result)
        }
    }
    
    
    //MARK: - METHODS FOR RECENT AND FAVORITES ARRAYS
    func saveRecentRecepie(recipe: RecipeDetail) { // вызвать при каждом открытии окна детального просмотра
        if !recentRecipesIDs.contains(recipe.id){
            recentRecipes.insert(recipe, at: 0)
        }
    }
    
    func saveFavoriteRecipe(recipe: RecipeDetail) { // при нажатии кнопки сохраниения в избранное // подумать как изменить структуру и параметр isFavorite
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
