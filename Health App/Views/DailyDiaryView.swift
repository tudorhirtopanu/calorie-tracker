//
//  DailyDiaryView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI
import SwiftData

struct DailyDiaryView: View {
    
    @State private var refreshID = UUID()
    
    @State private var textField: String = ""
    @State var isEditEnabled:Bool = false
    
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
    
    private func refreshView() {
            withAnimation {
                refreshID = UUID() // Change the value to trigger a refresh
            }
        }
    
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var dailyTaskManager = DailyTaskManager()
    
    @State var itemsToEdit:[FoodDataItem] = []
    
    private func deleteFoodData() {
        
        do {
            try context.delete(model: FoodDataItem.self)
        }
        catch {
           print("failed to delete model")
        }
        
    }
    
    private func deleteFoodItem(item:FoodDataItem){
        context.delete(item)
    }
    
    var body: some View {
        
       // var snackTotalCal =
        
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    if isEditEnabled{
                        Button(action: {
                            
                            for item in itemsToEdit {
                                deleteFoodItem(item: item)
                            }
                            
                            DispatchQueue.main.async {
                                withAnimation(.spring) {
                                    isEditEnabled = false
                                    
                                    refreshView()
                                }
                               }
                        }, label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width:25, height: 25)
                                .foregroundStyle(.red)
                        })
                        .padding(10)
                    }
                    
                }
                
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
                                        
                    ForEach(breakfastItems) { item in
                        
                        HStack {
                            
                            if isEditEnabled{
                                
                                if itemsToEdit.contains(item){
                                    Image(systemName: "checkmark.circle.fill")
                                        .padding(.leading,10)
                                        .fontWeight(.thin)
                                }
                                else {
                                    Image(systemName: "circle")
                                        .padding(.leading,10)
                                        .foregroundStyle(Color.primary)
                                }
                                
                            }
                            
                            FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize, isEditEnabled: $isEditEnabled, selectItem: {
                                
                                if !itemsToEdit.contains(item){
                                    itemsToEdit.append(item)
                                } else {
                                    itemsToEdit.removeAll(where: { $0 == item })
                                }
                                
                            })
                        }
                        
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
                        
                        HStack{
                            
                            if isEditEnabled{
                                
                                if itemsToEdit.contains(item){
                                    Image(systemName: "checkmark.circle.fill")
                                        .padding(.leading,10)
                                        .fontWeight(.thin)
                                }
                                else {
                                    Image(systemName: "circle")
                                        .padding(.leading,10)
                                        .foregroundStyle(Color.primary)
                                }
                                
                            }
                            
                            FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize, isEditEnabled: $isEditEnabled, selectItem: {
                                
                                if !itemsToEdit.contains(item){
                                    itemsToEdit.append(item)
                                } else {
                                    itemsToEdit.removeAll(where: { $0 == item })
                                }
                                
                            })
                        }
                        
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
                        
                        HStack{
                            
                            if isEditEnabled{
                                
                                if itemsToEdit.contains(item){
                                    Image(systemName: "checkmark.circle.fill")
                                        .padding(.leading,10)
                                        .fontWeight(.thin)
                                }
                                else {
                                    Image(systemName: "circle")
                                        .padding(.leading,10)
                                        .foregroundStyle(Color.primary)
                                }
                                
                            }
                            
                            FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize, isEditEnabled: $isEditEnabled, selectItem: {
                                
                                if !itemsToEdit.contains(item){
                                    itemsToEdit.append(item)
                                } else {
                                    itemsToEdit.removeAll(where: { $0 == item })
                                }
                                
                            })
                        }
                        
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
                        
                        HStack {
                            
                            if isEditEnabled{
                                
                                if itemsToEdit.contains(item){
                                    Image(systemName: "checkmark.circle.fill")
                                        .padding(.leading,10)
                                        .fontWeight(.thin)
                                }
                                else {
                                    Image(systemName: "circle")
                                        .padding(.leading,10)
                                        .foregroundStyle(Color.primary)
                                }
                                
                            }
                            
                            FoodItemButton(name: item.name, calories: item.calories, protein: item.protein, servingSize: item.servingSize, isEditEnabled: $isEditEnabled, selectItem: {
                                
                                if !itemsToEdit.contains(item){
                                    itemsToEdit.append(item)
                                } else {
                                    itemsToEdit.removeAll(where: { $0 == item })
                                }
                                
                            })
                        }
                        
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
