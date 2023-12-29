//
//  NixNutrition.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import Foundation

struct NixNutrition: Decodable {
    let foods:[NixFoods]
}

struct NixFoods:Decodable {
    let food_name:String
    let nf_calories:Int
    let serving_weight_grams:Int
}
