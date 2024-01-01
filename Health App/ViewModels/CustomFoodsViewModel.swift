//
//  CustomFoodsViewModel.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import Foundation

class CustomFoodsViewModel: ObservableObject {
    
    @Published var brandedFoods:[Food] = []
    
    @Published var mcdonaldsFoods:[Food] = []
    @Published var KFCFoods:[Food] = []
    
//    init(fileName: String, targetVariable: ReferenceWritableKeyPath<CustomFoodsViewModel, [Food]>) {
//            loadFoods(from: fileName, into: targetVariable)
//        }
    
//    private func loadFoods(from fileName: String, into keyPath: ReferenceWritableKeyPath<CustomFoodsViewModel, [Food]>) {
//        if let loadedFoods: [Food] = JSONHandler.decodeJSON([Food].self, fileName: fileName) {
//                self[keyPath: keyPath] = loadedFoods
//            }
//        }
    
}
