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
    var measuredByWeight:Bool
    var calories:Int
    var protein:Double
    var servingSize:String
    var creationDate:Date
    
    init(name: String, foodOccasion:Int, calories:Int, protein:Double, servingSize:String, measuredByWeight:Bool) {
        self.id = UUID().uuidString
        self.name = name
        self.foodOccasion = foodOccasion
        self.calories = calories
        self.protein = protein
        self.servingSize = servingSize
        self.measuredByWeight = measuredByWeight
        self.creationDate = Date()
    }
    
    static func example() -> FoodDataItem {
        return FoodDataItem(name: "Big Mac", foodOccasion: 0, calories: 400, protein: 32, servingSize: "1 serving", measuredByWeight: true)
    }
    
}
