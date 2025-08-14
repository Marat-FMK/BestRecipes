//
//  NetworkManager.swift
//  BestRecipes
//
//  Created by Marat Fakhrizhanov on 11.08.2025.
//

import Foundation

enum NetworkError: String, Error {
    case badURL = "❌Error - bad URL"
    case sessionError = "❌Error - URLSession"
    case data = "❌Error - no data"
    case decode = "❌Error - JSON decoder error / response"
}

enum worldCuisines: String {
    case american = "American"
    case european = "European"
    case greek = "Greek"
    case japanese = "Japanese"
    case mexican = "Mexican"
    case african = "African"
}

enum MealType: String {
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



class NetworkManager {
    
    private let scheme = "https"
    private let host = "api.spoonacular.com"
    private let pathComponent = "/recipes/complexSearch"
    private let apiKey = "793c4a9318a740b8af0b9f829165475d"
    
    
    func fetchRecipes(searchedText: String = "", cuisine: worldCuisines? = nil, mealType: MealType? = nil, maxRecipeCount: String = "5", completion: @escaping(Result<[SearchedRecipe],NetworkError>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = pathComponent
        
        
        //add author
        var queryItems = [URLQueryItem(name: "apiKey", value: apiKey),
                          URLQueryItem(name: "query", value: searchedText),
                          URLQueryItem(name: "number", value: maxRecipeCount),
                          URLQueryItem(name: "instructionsRequired", value: "true"),
                          URLQueryItem(name: "tags", value: "trend")]
        
        if cuisine != nil {
            queryItems.append(URLQueryItem(name: "cuisine", value: cuisine?.rawValue))
        }
        
        if cuisine != nil {
            queryItems.append(URLQueryItem(name: "type", value: mealType?.rawValue))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { completion(.failure(.badURL)); return}
        print("✅ Current URL -->", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type" : "application/json"
        ]
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { completion(.failure(.sessionError)); return}
            guard let data = data else { completion(.failure(.data)); return}
            
            do {
                let recipes = try JSONDecoder().decode(SearchedData.self, from: data)
                print("✅ SearchedRecipes --- >>", recipes.results)
                completion(.success(recipes.results))
            } catch {
                completion(.failure(.decode))
                print("NetworkManager", NetworkError.decode)
            }
        }.resume()
    }
    
    
    func fetchReceptsDetails(ids: [Int], completion: @escaping(Result<[RecipeDetail],NetworkError>) -> Void) {
        let stringIDs = ids.map { String($0)}.joined(separator: ",")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/recipes/informationBulk"
        
        urlComponents.queryItems = [URLQueryItem(name: "apiKey", value: apiKey),
                                    URLQueryItem(name: "ids", value: stringIDs)]
        
        guard let url = urlComponents.url else {completion(.failure(.badURL)); return}
        print("✅ Current URL recDetail -->", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-type" : "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data,response, error in
            guard error == nil else { completion(.failure(.sessionError)); return}
            guard let data = data else { completion(.failure(.data)); return}
            
            do {
                let recipes = try JSONDecoder().decode([RecipeDetail].self, from: data)
                print("✅ IDs: \(stringIDs), recipe detail -->>", recipes)
                completion(.success(recipes))
            } catch {
                completion(.failure(.decode))
            }
        }.resume()
    }
}


// 793c4a9318a740b8af0b9f829165475d

//Structs >>
// details : name / image url / rating / revies Count / instructions / ingredients / weightIngredients / time
// creatorName / creatorImageURL

// Fetch methods >>
// search reciepe/ trending now / popular category / popular creators  ---> 30 Items ?!?

