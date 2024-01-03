//
//  DailyNutrientData.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 03/01/2024.
//

import Foundation
import SwiftData

@Model
class DailyNutrientData: Identifiable {
    
    var id:String
    var day:Int
    var totalCalories:Int
    var totalProtein:Double
    var creationDate:Date
    
    init(day:Int, totalCalories:Int, totalProtein:Double) {
        self.id = UUID().uuidString
        self.day = day
        self.totalCalories = totalCalories
        self.totalProtein = totalProtein
        self.creationDate = Date()
    }
    
    static func example() ->DailyNutrientData {
        return DailyNutrientData(day: 2, totalCalories: 200, totalProtein: 10)
    }
    
}
