//
//  Health_AppApp.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import SwiftUI
import SwiftData

@main
struct Health_App: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: FoodDataItem.self)
        }
    }
}
