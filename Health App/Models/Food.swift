//
//  Food.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import Foundation

struct Food:Identifiable, Decodable {
    let id:Int
    let name:String
    //let image:URL?
    let measuredByWeight:Bool
    let servingSizes:[ServingSizes]
}

struct ServingSizes:Identifiable, Decodable {
    let id:Int
    let name:String
    let weight:Double
    let calories:Int
    let protein: Double
}
