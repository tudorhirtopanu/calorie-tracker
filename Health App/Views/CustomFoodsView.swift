//
//  CustomFoodsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 06/01/2024.
//

import SwiftUI
import SwiftData

struct CustomFoodsView: View {
        
    @Query private var customItems:[CustomFoodData]
    
    @State var searchText:String = ""
    
    @Environment(\.modelContext) private var context
    
    var searchResults:[CustomFoodData] {
        
        if searchText.isEmpty {
            return customItems
        } else {
            return customItems.filter {
                            $0.name.range(of: searchText, options: .caseInsensitive) != nil
                        }
        }
        
    }
    
    private func deleteFoodData() {
        
        do {
            try context.delete(model: CustomFoodData.self)
        }
        catch {
           print("failed to delete model")
        }
        
    }
    
    @EnvironmentObject var nm:NavigationManager
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                    .foregroundStyle(Color.gray.opacity(0.15))
                    .frame(height: 40)
                
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                    TextField("Search for food ...", text: $searchText)
                        //.focused($searchIsFocused)
                }
                .padding(8)
            }
            
            List {
                ForEach(searchResults){item in
                    NavigationLink(destination: CreateCustomFoodView(itemName: item.name, itemCal: String(item.calories), itemProtein: String(item.protein), isCustomFoodSaved:true).environmentObject(nm), label: {
                        Text(item.name)
                    })
                }
            }
            .listStyle(.plain)
            
            Spacer()
            
            Button(action: {
                deleteFoodData()
            }, label: {
                Text("Delete all data")
            })
            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    NavigationStack {
        CustomFoodsView()
            .modelContainer(previewContainer)
            .environmentObject(NavigationManager())
    }
}
