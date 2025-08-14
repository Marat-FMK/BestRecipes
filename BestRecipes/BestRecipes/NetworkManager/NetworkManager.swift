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
    
    private let maxRecipeCount = "20"
    
    func fetchSearchedRecipes(searchedText: String, completion: @escaping(Result<[String],NetworkError>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = pathComponent
        
        let queryItems = [URLQueryItem(name: "apiKey", value: apiKey),
                          URLQueryItem(name: "query", value: searchedText),
                          URLQueryItem(name: "number", value: maxRecipeCount)]
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { completion(.failure(.badURL)); return}
        print("✅ Current URL -->", url.absoluteString)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { completion(.failure(.sessionError)); return}
            guard let data = data else { completion(.failure(.data)); return}
            //            print(response)
            print(data)
            
            if let text = String(data: data, encoding: .utf8) {
                print(text)
            }
//            do {
//                print (data)
////                let questions = try JSONDecoder().decode(Questions.self, from: data)
////                print("✅ \(difficulty) questions --- >>", questions.results)
////                completion(.success(questions.results)) // array of questions
//            } catch {
//
////                completion(.failure(.decode))
//            }
            
        }.resume()
    }
    
}

// 793c4a9318a740b8af0b9f829165475d

//Structs >>
// details : name / image url / rating / revies Count / unstructions / ingredients / weightIngredients / time
// creatorName / creatorImageURL

// Fetch methods >>
// search reciepe/ trending now / popular category / popular creators  ---> 30 Items ?!?

