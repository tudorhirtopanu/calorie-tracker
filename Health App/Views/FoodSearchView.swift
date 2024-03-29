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
    //case nutritionixFood
    
    var id: Self { self }
}

enum Nutritionix:Hashable, Identifiable{
    case nutritionixFood
    
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
        
        ScrollView {
            VStack(alignment: .leading) {
                
                HStack {
                    
                    if searchIsFocused == true {
                        withAnimation {
                            Button(action:  {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                searchIsFocused = false
                                textField = ""
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.gray)
                            })
                            
                        }
                    }
                    
                    ZStack {
                        
                        RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                            .foregroundStyle(Color.gray.opacity(0.15))
                            .frame(height: 40)
                        
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.gray)
                            withAnimation {
                                TextField("Search for food ...", text: $textField)
                                    .focused($searchIsFocused)
                                    .submitLabel(.search)
                                    .onSubmit {
                                        searchIsFocused = false
                                        
                                        NutritionixService.shared.searchInstant2(query: textField) { result in
                                            self.foodItems = result
                                        }
                                        
                                        nm.showNixFoods = true
                                    }
                            }
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
                
                //            Button(action: {
                //
                //                searchIsFocused = false
                //
                //                NutritionixService.shared.searchInstant2(query: textField) { result in
                //                    self.foodItems = result
                //                }
                //
                //                nm.showNixFoods = true
                //
                //            }, label: {
                //                Text("Search")
                //            })
                //            .padding([.top, .bottom], 10)
                
                if nm.showNixFoods == true {
                    HStack {
                        Spacer()
                        
                        Button(action:  {
                            
                            nm.showNixFoods = false
                            
                            foodItems = nil
                            
                            textField = ""
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.gray)
                                .fontWeight(.medium)
                            
                        })
                        .padding(10)
                        
                    }
                }
                
                if nm.showNixFoods == false {
                    
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
                    
                    HStack{
                        Group {
                            BrandButton(fileName: "Mcdonalds", image: "McdonaldsLogo", brandName: "Mcdonalds")
                                .environmentObject(nm)
                            BrandButton(fileName: "KFC", image: "KfcLogo", brandName: "KFC")
                                .environmentObject(nm)
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 130)
                        .background(.gray.opacity(0.13), in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }
                    
                    Text("Common Foods")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .padding([.bottom, .top], 5)
                    
                    HStack {
                        Group {
                            BrandButton(fileName: "Meats", image: "meatsImg", brandName: "Meats & Protein")
                                .environmentObject(nm)
                                .frame(width:70)
                            
                            BrandButton(fileName: "Grains", image: "grainsImg", brandName: "Grains")
                                .environmentObject(nm)
                            
                            BrandButton(fileName: "Diary", image: "diaryImg", brandName: "Diary")
                                .environmentObject(nm)
                            
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 130)
                        .background(.gray.opacity(0.13), in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }
                    
                    Text("Snacks")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .padding([.bottom, .top], 5)
                    
                    HStack {
                        Group {
                            BrandButton(fileName: "Crisps", image: "crispsImg", brandName: "Crisps")
                                .environmentObject(nm)
                            
                            
                            BrandButton(fileName: "Cereal", image: "cerealImg", brandName: "Cereal")
                                .environmentObject(nm)
                            
                            BrandButton(fileName: "Pasteries", image: "pasteryImg", brandName: "Pasteries")
                                .environmentObject(nm)
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 130)
                        .background(.gray.opacity(0.13), in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }
                    
                }
                
                Spacer()
                
                if let foodItems = foodItems {
                    
                    if nm.showNixFoods{
                        ScrollView {
                            LazyVGrid(columns:[GridItem(), GridItem()]) {
                                
                                ForEach(foodItems.branded ?? [], id: \.foodName) { brandedItem in
                                    
                                    NavigationLink(value: brandedItem, label: {
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
            .navigationDestination(for: BrandedItem.self, destination: {brandedItem in
                FoodDetailView(text: brandedItem.foodName, itemId: brandedItem.nixItemId)
                    .environmentObject(nm)
            })
            .navigationDestination(for: BBLabel.self, destination: { state in
                
                CustomBrandFoodsView(fileToDecode: state.fileName, image: state.image)
                    .environmentObject(nm).onAppear{print(state)}
            })
            .padding(.horizontal)
        }
    }
}

struct Exampled:Identifiable, Hashable {
    var id:String
    var test:String
}

#Preview {
    NavigationStack{
        FoodSearchView()
            .environmentObject(NavigationManager())
            .modelContainer(previewContainer)
    }
}
