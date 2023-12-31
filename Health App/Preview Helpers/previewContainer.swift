//
//  previewContainer.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 31/12/2023.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: FoodDataItem.self, configurations: config)
        
        Task { @MainActor in
            
            let context = container.mainContext
            
            let dataItem = FoodDataItem.example()
            context.insert(dataItem)
            
            let item2 = FoodDataItem.example()
            context.insert(item2)
            
        }
        return container
    }
    catch {
       fatalError("Failed to create container")
    }
    
}()
