//
//  NutrientData.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 02/01/2024.
//

import Foundation
import SwiftData

@Model
class DailyNutrientData: Identifiable {
    
    var id:String
    var day:Int
    var totalCalories:Int
    var totalProtein:Double
    
    init( day: Int, totalCalories: Int, totalProtein: Double) {
        self.id = UUID().uuidString
        self.day = day
        self.totalCalories = totalCalories
        self.totalProtein = totalProtein
    }
    
    static func example() -> DailyNutrientData {
        return DailyNutrientData(day: 2, totalCalories: 2500, totalProtein: 120)
    }
    
}
/*
 1 - Mon
 7 - Sat
 */
