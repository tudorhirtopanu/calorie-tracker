//
//  Food.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import Foundation

struct Food:Encodable {
    let id:Int
    let name:String
    let image:URL?
    let servingSizes:[ServingSizes]
}

struct ServingSizes:Identifiable, Encodable {
    let id:Int
    let name:String
    let weight:Int
    let calories:Int
    let protein: Double
}
