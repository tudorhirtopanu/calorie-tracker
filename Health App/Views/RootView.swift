//
//  RootView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var nm:NavigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $nm.path){
            TabView{
                DailyDiaryView()
                    .environmentObject(nm)
                    .tabItem {
                        Label("Food", systemImage: "fork.knife")
                    }
                
                FoodSearchView()
                    .environmentObject(nm)
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
