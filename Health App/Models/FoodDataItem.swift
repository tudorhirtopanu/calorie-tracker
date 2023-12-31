//
//  FoodDataItem.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 30/12/2023.
//

import Foundation
import SwiftData

@Model
class FoodDataItem: Identifiable {
    
    var id:String
    var name:String
    var foodOccasion:Int
    var calories:Int
    var protein:Int
    
    init(name: String, foodOccasion:Int, calories:Int, protein:Int) {
        self.id = UUID().uuidString
        self.name = name
        self.foodOccasion = foodOccasion
        self.calories = calories
        self.protein = protein
    }
    
    static func example() -> FoodDataItem {
        return FoodDataItem(name: "Big Mac", foodOccasion: 0, calories: 400, protein: 32)
    }
    
}
