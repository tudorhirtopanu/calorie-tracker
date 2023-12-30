//
//  FatSecretService.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import Foundation

class FatSecretService {
    
    static let shared = FatSecretService()
    private let clientId = Secrets.fatsecretClientId
    private let clientSecret = Secrets.fatsecretClientSecret
    private let baseEndpoint = "https://platform.fatsecret.com/rest/server.api"
    
    // TODO: Function to refresh token
    
    func requestToken(completion: @escaping (Result<TokenResponse, Error>) -> Void) {
           let url = URL(string: "https://oauth.fatsecret.com/connect/token")!
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           
           let authString = "\(clientId):\(clientSecret)"
           if let authData = authString.data(using: .utf8) {
               let base64AuthString = authData.base64EncodedString()
               request.setValue("Basic \(base64AuthString)", forHTTPHeaderField: "Authorization")
           }
           
           let bodyData = "grant_type=client_credentials&scope=basic"
           request.httpBody = bodyData.data(using: .utf8)
           request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   completion(.failure(error))
                   return
               }
               
               if let data = data {
                   do {
                       let decoder = JSONDecoder()
                       let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
                       completion(.success(tokenResponse))
                       UserDefaults.standard.set(tokenResponse.access_token, forKey: "accessToken")
                       UserDefaults.standard.set(tokenResponse.expires_in, forKey: "tokenExpirationDate")
                   } catch {
                       print("Error decoding JSON: \(error)")
                       completion(.failure(error))
                   }
               }
           }
           
           task.resume()
       }
    
    func searchFood(searchExpression: String, accessToken: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let method = "foods.search"
        let baseUrl = "https://platform.fatsecret.com/rest/server.api"
        
        // Append the endpoint to the base URL
        guard var urlComponents = URLComponents(string: baseUrl) else {
            completion(.failure(NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "method", value: method)]
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        request.allHTTPHeaderFields = headers
        
        let parameters: [String: Any] = [
            "search_expression": searchExpression,
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            
            // Print request details for debugging
            if let bodyData = request.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
                print("Request URL: \(url)")
                print("Request Headers: \(headers)")
                print("Request Body: \(bodyString)")
            }
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "com.example", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }

    
    
}
