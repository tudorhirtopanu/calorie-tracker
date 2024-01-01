//
//  ContentView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import SwiftUI

struct FoodSearchView: View {
    
    @State private var textField: String = ""
    
    @State private var foodItems: NixFoodItems?
    @State private var isPresented:Bool = false
    @State private var presentCustomFood:Bool = false
    @State private var selectedFoodItemText: String = ""
    
    @FocusState private var searchIsFocused:Bool
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            HStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                        .foregroundStyle(Color.gray.opacity(0.15))
                        .frame(height: 40)
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.gray)
                        TextField("Search for food ...", text: $textField)
                            .focused($searchIsFocused)
                    }
                    .padding(8)
                }
                
                NavigationLink(destination: {
                    CreateCustomFoodView()
                }, label: {
                    VStack {
                        Image("fork.knife.badge.plus")
                        Text("Custom")
                            .font(Font.system(size: 12))
                    }
                })
                
            }
            
            Button(action: {
                
                searchIsFocused = false
                
                NutritionixService.shared.searchInstant2(query: textField) { result in
                    self.foodItems = result
                }
                
            }, label: {
                Text("Search")
            })
            .padding([.top, .bottom], 10)
            
//            Text("Recent Items")
//                .font(.caption)
//                .foregroundStyle(Color.gray)
            
//            if foodItems == nil {
//                Text("No Recent Items")
//                    .padding(.top, 10)
//            }
            
            Text("Popular Brands")
                .font(.caption)
                .foregroundStyle(Color.gray)
                .padding(.bottom, 5)
            
            if foodItems == nil {
                
                HStack{
                    BrandButton(fileName: "Mcdonalds", image: "McdonaldsLogo", brandName: "Mcdonalds")
                }
                
            }
            
            Spacer()
            
            if let foodItems = foodItems {
               
                ScrollView {
                    LazyVGrid(columns:[GridItem(), GridItem()]) {
                        
                        /*
                         //
                         //                            ForEach(foodItems.common ?? [], id: \.foodName) { commonItem in
                         //                                FoodItemRow(foodName: commonItem.foodName, imageURL: commonItem.photo.thumb)
                         //                                    .padding(.bottom,10)
                         //                            }
                         */
                        
                        ForEach(foodItems.branded ?? [], id: \.foodName) { brandedItem in
                            NavigationLink(destination: FoodDetailView(text: brandedItem.foodName, itemId: brandedItem.nixItemId),
                                           label: {
                                FoodItemRow(foodName: brandedItem.foodName, imageURL: brandedItem.photo.thumb)
                            })
                            .overlay(
                                // Add a single long Divider between the columns
                                Divider().frame(width: 1),
                                alignment: .leading
                            )
                            
                        }
                        
                    }.listRowSeparator(.visible)
                    
                    
                    
                }
            }
            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    NavigationStack{
        FoodSearchView()
    }
}
