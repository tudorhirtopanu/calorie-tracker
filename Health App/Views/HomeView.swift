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
                NutritionixService.shared.searchInstant(query: textField)
            }, label: {
                Text("Search")
            })
            .padding(.top, 10)
            
            if let foodItems = foodItems {
                List {
                    ForEach(foodItems.common ?? [], id: \.foodName) { commonItem in
                        FoodItemRow(foodName: commonItem.foodName, imageURL: commonItem.photo.thumb)
                    }
                    
                    ForEach(foodItems.branded ?? [], id: \.foodName) { brandedItem in
                        FoodItemRow(foodName: brandedItem.foodName, imageURL: brandedItem.photo.thumb)
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
