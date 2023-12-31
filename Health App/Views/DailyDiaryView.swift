//
//  DailyDiaryView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI
import SwiftData

struct DailyDiaryView: View {
    
    @State private var textField: String = ""
    @State private var isOverlayPresented:Bool = false
    
    @FocusState private var searchIsFocused:Bool
        
    @Query private var items:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 0
    }) private var breakfastItems:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 1
    }) private var lunchItems:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 2
    }) private var dinnerItems:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 3
    }) private var snackItems:[FoodDataItem]
    
    private func calculateCalories(itemArray:[FoodDataItem]) -> Int {
        
        let totalCalories = itemArray.reduce(0) { $0 + $1.calories }
        
        return totalCalories
    }
    
    private func calculateProtein(itemArray:[FoodDataItem]) -> Int {
        
        let totalProtein = itemArray.reduce(0) { $0 + $1.protein }
        
        return totalProtein
    }

    var body: some View {

            VStack {
                /*
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
                .padding(.bottom, 10)
                 */

                    HStack{
                        Text("Meal")
                            .padding(.leading,10)
                        Spacer()
                        Text("KCAL")
                            .frame(width:50)
                            .font(Font.system(size: 14))
                        Text("PROTg")
                            .frame(width:50)
                            .font(Font.system(size: 14))
                    }
                    
                    /*
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize( width: 50, height: 30))
                            .foregroundStyle(Color.gray.opacity(0.15))
                        .frame(height: 35)
                        
                        HStack {
                            Text("BREAKFAST")
                                .padding(.leading)
                                .font(Font.system(size: 14))
                            Spacer()
                            
                            
                        }
                        
                    }
                     */
                        
                ScrollView{
                    
                    HStack {
                        Text("Breakfast")
                            .fontWeight(.semibold)
                            .padding(.leading,10)
                        Spacer()
                        Text(String(calculateCalories(itemArray: breakfastItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        Text(String(calculateProtein(itemArray: breakfastItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        
                    }
                    .overlay(content: {
                        RoundedRectangle(cornerSize: CGSize( width: 20, height: 20))
                            .foregroundStyle(Color.gray.opacity(0.2))
                            .frame(height: 40)
                    })
                    .padding(.top)
                    
                    
                    //Divider()
                    
                    ForEach(breakfastItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein)
                        
                    }
                    .padding([.bottom, .top],1)
                    
                    
                    
                    HStack {
                        Text("Lunch")
                            .fontWeight(.semibold)
                            .padding(.leading,10)
                        Spacer()
                        Text(String(calculateCalories(itemArray: lunchItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        Text(String(calculateProtein(itemArray: lunchItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        
                    }
                    .overlay(content: {
                        RoundedRectangle(cornerSize: CGSize( width: 20, height: 20))
                            .foregroundStyle(Color.gray.opacity(0.2))
                            .frame(height: 40)
                    })
                    .padding(.top)
                                        
                    ForEach(lunchItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein)
                       
                    }
                    
                    HStack {
                        Text("Dinner")
                            .fontWeight(.semibold)
                            .padding(.leading,10)
                        Spacer()
                        Text(String(calculateCalories(itemArray: dinnerItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        Text(String(calculateProtein(itemArray: dinnerItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        
                    }
                    .overlay(content: {
                        RoundedRectangle(cornerSize: CGSize( width: 20, height: 20))
                            .foregroundStyle(Color.gray.opacity(0.2))
                            .frame(height: 40)
                    })
                    .padding(.top)
                                        
                    ForEach(dinnerItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein)
                       
                    }
                    
                    HStack {
                        Text("Snacks")
                            .fontWeight(.semibold)
                            .padding(.leading,10)
                        Spacer()
                        Text(String(calculateCalories(itemArray: snackItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        Text(String(calculateProtein(itemArray: snackItems)))
                            .fontWeight(.semibold)
                            .frame(width:50)
                        
                    }
                    .overlay(content: {
                        RoundedRectangle(cornerSize: CGSize( width: 20, height: 20))
                            .foregroundStyle(Color.gray.opacity(0.2))
                            .frame(height: 40)
                    })
                    .padding(.top)
                                        
                    ForEach(snackItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein)
                       
                    }
                    
                    
                                        
                }
                
                Spacer()
                
                Divider()
                
                    VStack {
                        HStack{
                            Text("TOTALS")
                            
                            Spacer()
                            Text("KCAL")
                                .frame(width:50)
                                .font(Font.system(size: 14))
                            Text("PROTg")
                                .frame(width:50)
                                .font(Font.system(size: 14))
                        }
                        .padding(.bottom, 10)
                        .fontWeight(.medium)
                        
                            VStack {
                                HStack{
                                    Text("GOAL")
                                    
                                    Spacer()
                                    Text("3000")
                                        .frame(width:50)
                                    Text("135")
                                        .frame(width:50)
                                }
                                .foregroundStyle(Color.orange)
                                .fontWeight(.medium)
                                
                                HStack{
                                    Text("FOOD")
                                    
                                    Spacer()
                                    Text(String(calculateCalories(itemArray: items)))
                                        .frame(width:50)
                                    Text(String(calculateProtein(itemArray: items)))
                                        .frame(width:50)
                                }
                                .foregroundStyle(Color.green)
                                .fontWeight(.medium)
                                
                                Divider()
                                
                                HStack{
                                    Text("LEFT")
                                    
                                    Spacer()
                                    Text(String(3000 - calculateCalories(itemArray: items)))
                                        .frame(width:50)
                                    Text(String(135 - calculateProtein(itemArray: items)))
                                        .frame(width:50)
                                }
                                .foregroundStyle(Color.red)
                                .fontWeight(.medium)
                                
                            }
                        
                    }
                    .frame(height:100)
                    .padding([.bottom, .top],10)
            }
            .padding(.horizontal)
    }
}

#Preview {
    DailyDiaryView()
        .modelContainer(previewContainer)
}
