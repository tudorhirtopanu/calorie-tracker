//
//  Food.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import Foundation

struct Food:Identifiable, Decodable {
    var id:Int
    var name:String
    let image:URL?
    var measuredByWeight:Bool
    var servingSizes:[ServingSizes]
}

struct ServingSizes:Identifiable, Decodable {
    var id:Int
    var name:String
    var weight:Double
    var calories:Int
    var protein: Double
}

