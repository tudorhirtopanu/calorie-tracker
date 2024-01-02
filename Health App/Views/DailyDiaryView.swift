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
    @State private var isEditEnabled:Bool = false
    
    @FocusState private var searchIsFocused:Bool
    
    @Query private var items:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 0
    }, sort: \.creationDate, order: .forward) private var breakfastItems:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 1
    }, sort: \.creationDate, order: .forward) private var lunchItems:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 2
    }, sort: \.creationDate, order: .forward) private var dinnerItems:[FoodDataItem]
    
    @Query(filter: #Predicate<FoodDataItem>{food in
        food.foodOccasion == 3
    }, sort: \.creationDate, order: .forward) private var snackItems:[FoodDataItem]
    
    private func calculateCalories(itemArray:[FoodDataItem]) -> Int {
        
        let totalCalories = itemArray.reduce(0) { $0 + $1.calories }
        
        return totalCalories
    }
    
    private func calculateProtein(itemArray:[FoodDataItem]) -> Double {
        
        let totalProtein = itemArray.reduce(0) { $0 + $1.protein }
        
        let roundedProtein = (totalProtein * 10).rounded() / 10
        
        return roundedProtein
    }
    
    private func truncateDouble(number: Double, decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return Double(Int(number * multiplier)) / multiplier
    }
    
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var dailyTaskManager = DailyTaskManager()
    
    private func deleteFoodData() {
        
        do {
            try context.delete(model: FoodDataItem.self)
        }
        catch {
           print("failed to delete model")
        }
        
    }
    
    var body: some View {
        
            VStack {
                
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
                    .padding(.bottom, breakfastItems == [] ? 0 : 10)
                    
                    //Divider()
                    
                    ForEach(breakfastItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize)
                        
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
                    .padding(.bottom, lunchItems == [] ? 0 : 10)
                    
                    ForEach(lunchItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize)
                        
                    }
                    .padding([.bottom, .top],1)
                    
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
                    .padding(.bottom, dinnerItems == [] ? 0 : 10)
                    
                    ForEach(dinnerItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize)
                        
                    }
                    .padding([.bottom, .top],1)
                    
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
                    .padding(.bottom, snackItems == [] ? 0 : 10)
                    
                    ForEach(snackItems) { item in
                        
                        FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize)
                        
                    }
                    .padding([.bottom, .top],1)
                    
                    
                    
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
                            Text(String(truncateDouble(number: 135 - calculateProtein(itemArray: items), decimalPlaces: 1)))
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
            .onChange(of: scenePhase, { oldValue, newValue in
                if newValue == .active {
                    Task {
                        
                        if await dailyTaskManager.performDailyTaskIfNeeded() {
                            // TODO: Save daily total and date before deleting
                            await MainActor.run {
                                deleteFoodData()
                            }
                        }
                        
                    }
                }
            })
                
    }
}

#Preview {
    NavigationStack {
        DailyDiaryView()
            .modelContainer(previewContainer)
    }
}
