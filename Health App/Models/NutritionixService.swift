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
    
    func searchInstant(query:String) {
        
        let endpoint = "\(baseEndpoint)/search/instant"
        
        guard var components = URLComponents(string: endpoint) else {
            print("Invalid URL")
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        // Create a GET request with the constructed URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-app-key")
        request.addValue(appId, forHTTPHeaderField: "x-app-id")
        
        URLSession.shared.dataTask(with: request){data ,response, error in
            
            // Check for errors in the request
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Check if data was received
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            // Print the raw JSON response to the console
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            } else {
                print("Error converting data to string")
            }
            
        }.resume()
        
    }
    
    func searchInstant2(query: String) {
        let url = URL(string: "https://trackapi.nutritionix.com/v2/search/instant/?query=\(query)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
    
}
