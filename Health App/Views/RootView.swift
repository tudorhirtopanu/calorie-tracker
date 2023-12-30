//
//  RootView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack{
            TabView{
                DailyDiaryView()
                    .tabItem {
                        Label("Food", systemImage: "fork.knife")
                    }
                
                FoodSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
            
        }
    }
}

#Preview {
    RootView()
}
