//
//  Secrets.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import Foundation

struct Secrets {
    
    static let nutritionixApiKey:String =  {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["NutritionixApiKey"] as? String
        else {
            fatalError("Configuration file not found or missing Nutritionix API key.")
        }
        return apiKey
    }()
    
    static let nutritionixAppId:String =  {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["NutritionixAppID"] as? String
        else {
            fatalError("Configuration file not found or missing Nutritionix APP Id.")
        }
        return apiKey
    }()
    
}
