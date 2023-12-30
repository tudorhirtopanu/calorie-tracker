//
//  NutritionixService.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import Foundation

class NutritionixService {
    
    static let shared = NutritionixService()
    private let apiKey = Secrets.nutritionixApiKey
    private let appId = Secrets.nutritionixAppId
    private let baseEndpoint = "https://api.nutritionix.com/v2"
    
    func searchInstant(query: String) {
        let url = URL(string: "https://trackapi.nutritionix.com/v2/search/instant/?query=\(query)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue(appId, forHTTPHeaderField: "x-app-id")
        request.addValue(apiKey, forHTTPHeaderField: "x-app-key")
        
        // for development set to 0
        request.addValue("0", forHTTPHeaderField: "x-remote-user-id")
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            } else {
                print("Error converting data to string")
            }
        }.resume()
    }
    
    func fetchItemInfo(itemId: String) async throws -> NixFoods {
        let url = URL(string: "https://trackapi.nutritionix.com/v2/search/item/?nix_item_id=\(itemId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue(appId, forHTTPHeaderField: "x-app-id")
        request.addValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.addValue("0", forHTTPHeaderField: "x-remote-user-id")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON String: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            let nutrition = try decoder.decode(NixNutrition.self, from: data)
            
            guard let specificItem = nutrition.foods.first else {
                throw NSError(domain: "Specific item not found", code: 0, userInfo: nil)
            }
            
            return specificItem
        } catch {
            print("Error fetching item info: \(error)")
            throw error
        }
    }
    
    func searchInstant2(query: String, completion: @escaping (NixFoodItems?) -> Void) {
        
        let url = URL(string: "https://trackapi.nutritionix.com/v2/search/instant/?query=\(query)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue(appId, forHTTPHeaderField: "x-app-id")
        request.addValue(apiKey, forHTTPHeaderField: "x-app-key")
        
        // for development set to 0
        request.addValue("0", forHTTPHeaderField: "x-remote-user-id")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
        
            if let error = error {
                print("Error 1: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(NixFoodItems.self, from: data)
                completion(result)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
            
        }.resume()
        
    }
    
    
    
}
