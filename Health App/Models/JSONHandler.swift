//
//  JSONHandler.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import Foundation

class JSONHandler {
    
    static func decodeJSON<T: Decodable>(_ type: T.Type, fileName: String) -> T {
        do {
            if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(type, from: jsonData)
                return decodedData
            } else {
                print("File not found in the app bundle: \(fileName).json")
            }
        } catch {
            print("Error reading JSON from file: \(error)")
        }
        return [] as! T
    }
    
}
