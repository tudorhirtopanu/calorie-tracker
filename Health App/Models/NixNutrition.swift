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
//    let photo:Photo
//    let serving_weight_grams:Int
//    let nf_calories:Int
//    let nf_protein:Int
//    let nf_total_carbohydrate:Int
//    let nf_total_fat:Int
   
}
