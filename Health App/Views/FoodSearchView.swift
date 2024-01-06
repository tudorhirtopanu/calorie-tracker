//
//  ContentView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import SwiftUI

enum FoodSearchNav:Hashable, Identifiable{
    case addCustomFood
    case savedView
    
    var id: Self { self }
}

struct FoodSearchView: View {
    
    @State private var textField: String = ""
    
    @State private var foodItems: NixFoodItems?
    @State private var confirmItem:Bool = false
    @State private var presentCustomFood:Bool = false
    @State private var selectedFoodItemText: String = ""
    
    @FocusState private var searchIsFocused:Bool
    
    @EnvironmentObject var nm:NavigationManager
    
    private struct CustomValue:Hashable {
        let customFoodView:Int
        let savedFoodView:Int
    }
    
    
    
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
                
                NavigationLink(value: FoodSearchNav.addCustomFood, label: {
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
            
//            Button(action: {
//                confirmItem.toggle()
//            }, label: {
//                Text("show popover")
//            })
            
            NavigationLink(value: FoodSearchNav.savedView, label: {
                HStack{
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                    
                    Text("Custom Foods")
                }
                .padding(10)
                .background(.gray.opacity(0.25), in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
            })
            
            Text("Popular Brands")
                .font(.caption)
                .foregroundStyle(Color.gray)
                .padding([.bottom, .top], 5)
            
            if foodItems == nil {
                
                HStack{
                    BrandButton(fileName: "Mcdonalds", image: "McdonaldsLogo", brandName: "Mcdonalds")
                        .environmentObject(nm)
                }
                
            }
            
            Spacer()
            
            if let foodItems = foodItems {
               
                ScrollView {
                    LazyVGrid(columns:[GridItem(), GridItem()]) {
                        
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
        .navigationDestination(for: FoodSearchNav.self) { state in
            switch state {
            case .addCustomFood:
                CreateCustomFoodView()
                    .environmentObject(nm)
                
            case .savedView:
                CustomFoodsView()
                    .environmentObject(nm)
            }
                            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    NavigationStack{
        FoodSearchView()
            .environmentObject(NavigationManager())
            .modelContainer(previewContainer)
    }
}
