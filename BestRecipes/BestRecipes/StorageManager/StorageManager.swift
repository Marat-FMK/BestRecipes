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
    case african = "African"
//    case asian = "Asian"
    case american = "American"
    case british = "British"
//    case cajun = "Cajun"
//    case caribbean = "Caribbean"
    case chinese = "Chinese"
//    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
//    case jewish = "Jewish"
    case korean = "Korean"
//    case latinAmerican = "Latin American"
//    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
//    case middleEastern = "Middle Eastern"
//    case nordic = "Nordic"
//    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
}

enum MealType: String, CaseIterable {
    case dessert = "dessert"
    //    case appetizer = "appetizer"
    case salad = "salad"
    case soup = "soup"
    //    case snack = "snack"
    case drink = "drink"
    //    case sideDish = "side dish"
    case bread = "bread"
    //    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    //    case fingerfood = "fingerfood"
}


final class StorageManager {
    
    static let shared = StorageManager()
    
    private let networkManager = NetworkManager()
    
    let categories = MealType.allCases.map{ String($0.rawValue) } // массив категорий для главного экрана
    let cuisineNamesAll = WorldCuisines.allCases.map{ String($0.rawValue) } // массив кухонь мира для главного экрана
    var cuisineNames: [String] {
        var randomCuisines = [String]()
        for _ in 1...5 {
            guard let cuisine = cuisineNamesAll.randomElement() else { return ["American", "Mexican", "European", "British"] }
            randomCuisines.append(cuisine)
        }
        return randomCuisines
    }
    
    
    var currentCategory: MealType {
        let uDCategory = UserDefaults.standard.string(forKey: Constants.UDConstants.currentCategory) ?? "dessert" // сюда сохраняем выбранную на HomeView категорию в UD
        
        switch uDCategory {
        case "dessert": return .dessert
            //        case "appetizer": return .appetizer
        case "salad": return .salad
        case "soup": return .soup
            //        case "snack": return .snack
        case "drink": return .drink
            //        case "sideDish": return .sideDish
        case "bread": return .bread
            //        case "beverage": return .beverage
        case "sauce": return .sauce
        case "marinade": return .marinade
            //        case "fingerfood": return .fingerfood
        default: return .bread
        }
    }
    
    var searchText = "" // при изменении искомого слова - передаем его в этот паараметр и вызываем ф-ию setSearchRecipes
    
    var searchedRecipes: [RecipeDetail] = [] // массив наполняется после вызова ф-ии setSearchRecipes
    
    var choosedCuisine = WorldCuisines.american // выбранная страна
    var currentCuisineRecipes: [RecipeDetail] = [] // массив наполняется после вызова ф-ии setCurrentCuisineRecipes
    
    var myRecipes: [RecipeDetail] {
        if let data = UserDefaults.standard.data(forKey: Constants.UDConstants.myRecipes) {
            if let recipes = try? JSONDecoder().decode([RecipeDetail].self, from: data) {
                return recipes
            }
        }
        return []
    }
    
    var favoriteRecipes: [RecipeDetail] {
        if let data = UserDefaults.standard.data(forKey: Constants.UDConstants.savedFavoriteRecipes) {
            if let recipes = try? JSONDecoder().decode([RecipeDetail].self, from: data) {
                return recipes
            }
        }
        return []
    }
    
    var favoriteRecipesIDs: [Int] {
        var favoriteRecipeIDs: [Int] = []
        for recipe in favoriteRecipes{
            favoriteRecipeIDs.append(recipe.id)
        }
        return favoriteRecipeIDs
    }
    
    var trendingRecipesAll: [RecipeDetail] = [] // все рецепты которые загружаются при старте
    var trendingRecipes: [RecipeDetail] { // отдает только 5 рецептов для показа на Home view
        setArrayForHomeView(allRecipes: trendingRecipesAll)
    }
    
    var categoryRecipesAll: [RecipeDetail] = [] // все рецепты которые загружаются при выборе очередной категории
    var categoryRecipes: [RecipeDetail] { // отдает только 5 рецептов для показа на Home view
        setArrayForHomeView(allRecipes: categoryRecipesAll)
    }
    
    //    var recentRecipes: [RecipeDetail] { // сохраняет массив просмотренных исупользую ф-ию saveRecentRecepie
    //        let decoder = JSONDecoder()
    //        let data = UserDefaults.standard.data(forKey: Constants.UDConstants.savedRecentRecipes)
    //        do {
    //            let reciepes = try decoder.decode([RecipeDetail].self, from: data!)
    //        } catch {
    //            print("Recent recipes error")
    //        }
    //    }
    
    var recentRecipes: [RecipeDetail] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Constants.UDConstants.savedRecentRecipes) else {
                return []
            }
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([RecipeDetail].self, from: data)
            } catch {
                print("Recent recipes error: \(error)")
                return []
            }
        }
    }
    
    var recentRecipesIDs: [Int] { // нужен для проверки перед добавлением нового просмотренного что бы не дублироваться
        var intermediate: [Int] = []
        if !recentRecipes.isEmpty {
            for recipe in recentRecipes {
                intermediate.append(recipe.id)
            }
        }
        return intermediate
    }
    
    
    private init() {}
    
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
    private func setArrayOfRecipeDetails(direction: Direction,
                                         result: Result<[SearchedRecipe],NetworkError>,
                                         completion: @escaping ( () -> Void )) {
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
                        completion()
                    case .category:
                        self.categoryRecipesAll = recipes
                        completion()
                    case .search:
                        self.searchedRecipes = recipes
                        completion()
                    case .cuisines:
                        self.currentCuisineRecipes = recipes
                        completion()
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
    //    func setCategotyRecipes() {
    //        networkManager.fetchRecipes(mealType: currentCategory) { result in
    //            self.setArrayOfRecipeDetails(direction: .category, result: result)
    //        }
    //    }
    func setCategotyRecipes(completion: @escaping ( () -> Void )) {
        networkManager.fetchRecipes(mealType: currentCategory) { result in
            self.setArrayOfRecipeDetails(direction: .category, result: result) {
                completion()
            }
            
        }
    }
    
    func setTrendingRecipes(completion: @escaping ( () -> Void )) {
        networkManager.fetchRecipes(trend: true) { result in
            self.setArrayOfRecipeDetails(direction: .trending, result: result){
                completion()
            }
        }
    }
    
    func setSearchRecipes(completion: @escaping ( () -> Void )) {
        networkManager.fetchRecipes(searchedText: searchText) { result in // добавить параметр максимального кол-ва рецептов в ф-ию при необходимости
            self.setArrayOfRecipeDetails(direction: .search, result: result){
                completion()
            }
        }
    }
    
    func setCurrentCuisineRecipes(completion: @escaping ( () -> Void )) {
        networkManager.fetchRecipes(cuisine: choosedCuisine) { result in
            self.setArrayOfRecipeDetails(direction: .cuisines, result: result){
                completion()
            }
        }
    }
    
    
    //MARK: - METHODS FOR RECENT AND FAVORITES ARRAYS
    
    private func saveToUD(recipes: [RecipeDetail], constantUD: String) {
        if let encoded = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encoded, forKey: constantUD)
            print("💼✅ Encode complete, save -->>", recipes)
        }
    }
    
    
    func saveRecentRecepie(recipe: RecipeDetail) {
        if !recentRecipesIDs.contains(recipe.id) {
            var recipes = recentRecipes
            recipes.insert(recipe, at: 0)
            
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(recipes)
                UserDefaults.standard.set(data, forKey: Constants.UDConstants.savedRecentRecipes)
            } catch {
                print("Error save recent to UD / encode : \(error)")
            }
        }
    }
    
    func saveMyRecipe(recipe: RecipeDetail) {
        var recipes = myRecipes
        recipes.append(recipe)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(recipes)
            UserDefaults.standard.set(data, forKey: Constants.UDConstants.myRecipes)
            print("💼✅ my recipes --- >> ", recipes)
        } catch {
            print("Error save myRecept to UD / encode : \(error)")
        }
    }
    
    func saveFavoriteRecipe(recipe: RecipeDetail) {
        var favorites = favoriteRecipes
        if !favorites.contains(where: { $0.id == recipe.id }) {
                favorites.append(recipe)
                saveToUD(recipes: favorites, constantUD: Constants.UDConstants.savedFavoriteRecipes)
                print("✅ Recipe saved to favorites")
            } else {
                print("⚠️ Recipe already in favorites")
            }
        }
    
    func deleteFavoriteRecipe(recipe: RecipeDetail) {
        var favorites = favoriteRecipes
        
        if let index = favorites.firstIndex(where: { $0.id == recipe.id} ) {
            favorites.remove(at: index)
        }
        saveToUD(recipes: favorites, constantUD: Constants.UDConstants.savedFavoriteRecipes)
    }
    
    func removeDuplicateFavorites() {
        var uniqueRecipes: [RecipeDetail] = []
        var seenIDs: Set<Int> = []
        
        for recipe in favoriteRecipes {
            if !seenIDs.contains(recipe.id) {
                uniqueRecipes.append(recipe)
                seenIDs.insert(recipe.id)
            }
        }
        
        if uniqueRecipes.count != favoriteRecipes.count {
            saveToUD(recipes: uniqueRecipes, constantUD: Constants.UDConstants.savedFavoriteRecipes)
            print("✅ Removed \(favoriteRecipes.count - uniqueRecipes.count) duplicates")
        }
    }
    
    //MARK: TRANSLATER METHODS
       
       func translateRecipe(recipe: RecipeDetail, completion: @escaping (RecipeDetail) -> Void) {
//           let udLanguage = UserDefaults.standard.string(forKey: Constants.UDConstants.language) ?? "ru"
//           
//           guard udLanguage == "ru" else {
//               completion(recipe)
//               return
//           }
           
           let translater = TranslaterManager()
           
           let title = recipe.title
           let instruction = recipe.instructions
           let originalExtendedIngredients = recipe.extendedIngredients
           
           let stringIngredientsArray = originalExtendedIngredients.map { $0.name }
           
           translater.translateText(text: [title, instruction] + stringIngredientsArray) { result in
               switch result {
               case .success(let translated):
                   guard translated.count >= 2 + stringIngredientsArray.count else {
                       completion(recipe)
                       return
                   }
                   
                   let translatedTitle = translated[0].text
                   let translatedInstruction = translated[1].text
                   
                   var translatedIngredients: [ExtendedIngredient] = []
                   for (index, orig) in originalExtendedIngredients.enumerated() {
                       let translatedName = translated[index + 2].text
                       let newIngredient = ExtendedIngredient(
                           name: translatedName,
                           amount: orig.amount,
                           unit: orig.unit,
                           consistency: orig.consistency,
                           image: orig.image
                       )
                       translatedIngredients.append(newIngredient)
                   }
                   
                   let newRecipe = RecipeDetail(
                       id: recipe.id,
                       title: translatedTitle,
                       image: recipe.image,
                       spoonacularScore: recipe.spoonacularScore,
                       instructions: translatedInstruction,
                       preparationMinutes: recipe.preparationMinutes,
                       cookingMinutes: recipe.cookingMinutes,
                       readyInMinutes: recipe.readyInMinutes,
                       extendedIngredients: translatedIngredients,
                       sourceName: recipe.sourceName,
                       sourceUrl: recipe.sourceUrl,
                       vegetarian: recipe.vegetarian,
                       glutenFree: recipe.glutenFree,
                       servings: recipe.servings
                   )
                   
                   completion(newRecipe)
                   
               case .failure(let error):
                   print("❌ Translate error", error)
                   completion(recipe)
               }
           }
       }
}
