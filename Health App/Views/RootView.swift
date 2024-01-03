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
                
                InsightsView()
                    .environmentObject(nm)
                    .tabItem {
                        Label("Insights", systemImage: "chart.bar.fill")
                    }
            }
            
        }
        .overlay(content: {
            if nm.presentConfirmation {
                ConfirmationPopover()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                            withAnimation(.spring) {
                                nm.presentConfirmation.toggle()
                            }
                        })
                    }
            }
        })
        
    }
}

#Preview {
    RootView()
}
