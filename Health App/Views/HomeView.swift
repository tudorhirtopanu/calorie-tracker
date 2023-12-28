//
//  ContentView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var textField: String = ""
    
    @State private var foodItems: FoodItems?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search for food ...", text: $textField)
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                        .stroke(Color.gray, lineWidth: 1)
                }
            
            Button(action: {
                NutritionixService.shared.searchInstant2(query: textField) { result in
                    self.foodItems = result
                }
            }, label: {
                Text("Search")
            })
            .padding(.top, 10)
            
            // TODO: Create reusable view for each food item
            if let foodItems = foodItems {
                List {
                    ForEach(foodItems.common ?? [], id: \.tagId) { commonItem in
                        HStack {
                            Text(commonItem.foodName)
                            
                        }
                    }
                    
                    ForEach(foodItems.branded ?? [], id: \.nixItemId) { brandedItem in
                        Text(brandedItem.foodName)
                    }
                }
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
