//
//  CustomFoodData.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 06/01/2024.
//

import Foundation
import SwiftData

@Model
class CustomFoodData:Identifiable {
    
    var id:String
    var name:String
    var calories:Int
    var protein:Double
    var servingSize:String
    
    init(name: String, calories: Int, protein: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.calories = calories
        self.protein = protein
        self.servingSize = "1 serving"
    }
    
    static func example() -> CustomFoodData {
        return CustomFoodData(name: "Kebab", calories: 300, protein: 32)
    }
    
}
