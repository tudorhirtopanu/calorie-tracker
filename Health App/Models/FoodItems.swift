//
//  CommonItemType.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import Foundation

struct FoodItems:Codable {
    let common:[CommonItem]?
    let branded:[BrandedItem]?
}

struct CommonItem: Codable {
    let foodName:String
    let servingUnit:String
    let tagName:String
    let servingQty:Double
    let commonType:Int?
    let tagId:String
    let photo:Photo
    let locale: String
}

struct BrandedItem: Codable {
    let foodName:String
    let servingUnit:String
    let nixBrandId:String
    let brandNameItemName:String
    let servingQty:Double
    let nfCalories:Double
    let photo:Photo
    let brandName:String
    let region:Int
    let brandType:Int
    let nixItemId:String
    let locale:String
}

struct Photo: Codable {
    let thumb: URL
    let highres: String?
    let isUserUploaded: Bool?
}
