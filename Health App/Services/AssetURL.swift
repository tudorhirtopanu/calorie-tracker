//
//  AssetURL.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 08/01/2024.
//

import Foundation

struct AssetURL {
    static func url(for assetName: String) -> URL? {
        guard let path = Bundle.main.path(forResource: assetName, ofType: "png") else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
}
