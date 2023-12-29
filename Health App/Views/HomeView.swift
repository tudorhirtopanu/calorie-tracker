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
        ZStack {
                        
            VStack(alignment: .leading) {
                ZStack {
                    
                    RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                        .foregroundStyle(Color.gray.opacity(0.15))
                        .frame(height: 40)
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.gray)
                        TextField("Search for food ...", text: $textField)
                    }
                    .padding(8)
                }
                
                Button(action: {
                    NutritionixService.shared.searchInstant2(query: textField) { result in
                        self.foodItems = result
                    }
                   
                }, label: {
                    Text("Search")
                })
                .padding([.top, .bottom], 10)
                
                Spacer()
                
                if let foodItems = foodItems {
                    
                    ScrollView {
                        LazyVGrid(columns:[GridItem(), GridItem()]) {
                            ForEach(foodItems.common ?? [], id: \.foodName) { commonItem in
                                FoodItemRow(foodName: commonItem.foodName, imageURL: commonItem.photo.thumb)
                                    .padding(.bottom,10)
                            }
                            
                            ForEach(foodItems.branded ?? [], id: \.foodName) { brandedItem in
                                FoodItemRow(foodName: brandedItem.foodName, imageURL: brandedItem.photo.thumb)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    
                   // List {
    //                    ForEach(foodItems.common ?? [], id: \.foodName) { commonItem in
    //                        FoodItemRow(foodName: commonItem.foodName, imageURL: commonItem.photo.thumb)
    //                    }
                        
    //                    ForEach(foodItems.branded ?? [], id: \.foodName) { brandedItem in
    //                        FoodItemRow(foodName: brandedItem.foodName, imageURL: brandedItem.photo.thumb)
    //                    }
                   // }
                }
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
