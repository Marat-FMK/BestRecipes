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

class NetworkManager {
    
    private let scheme = "https"
    private let host = "api.spoonacular.com"
    private let pathComponent = "/recipes/complexSearch"
    private let apiKey = "793c4a9318a740b8af0b9f829165475d"
    
#warning("max recipe count / ApiKey")
    func fetchRecipes(searchedText: String? = nil,
                      trend: Bool = false,
                      cuisine: WorldCuisines? = nil,
                      mealType: MealType? = nil,
                      maxRecipeCount: String = "1",
                      completion: @escaping(Result<[SearchedRecipe],NetworkError>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = pathComponent
        
        
        var queryItems = [URLQueryItem(name: "apiKey", value: apiKey),
                          URLQueryItem(name: "number", value: maxRecipeCount),
                          URLQueryItem(name: "instructionsRequired", value: "true")]
        
        var direction: Direction = .search
        if searchedText != nil {
            direction = .search
            queryItems.append(URLQueryItem(name: "query", value: searchedText))
        }
        
        if trend {
            direction = .trending
            queryItems.append(URLQueryItem(name: "sort", value: "popularity"))
        }
        
        if cuisine != nil {
            direction = .cuisines
            queryItems.append(URLQueryItem(name: "cuisine", value: cuisine?.rawValue))
        }
        
        if mealType != nil {
            direction = .category
            queryItems.append(URLQueryItem(name: "type", value: mealType?.rawValue))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { completion(.failure(.badURL)); return}
        print("✅ Current URL \(direction.rawValue) -- >", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type" : "application/json"
        ]
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { completion(.failure(.sessionError)); return}
            guard let data = data else { completion(.failure(.data)); return}
            
            do {
                let recipes = try JSONDecoder().decode(SearchedData.self, from: data)
                print("✅ SearchedRecipes \(direction.rawValue) --- >>", recipes.results)
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
        print("✅ Current URL recipeDetail -->", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-type" : "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data,response, error in
            guard error == nil else { completion(.failure(.sessionError)); return}
            guard let data = data else { completion(.failure(.data)); return}
            
            do {
                let recipes = try JSONDecoder().decode([RecipeDetail].self, from: data)
                //                print("✅ IDs: \(stringIDs), recipe detail -->>", recipes)
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

