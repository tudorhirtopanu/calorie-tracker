//
//  CreateCustomFoodView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 30/12/2023.
//

import SwiftUI
import SwiftData

enum FoodOccasions:Int {
    case breakfast = 0
    case lunch = 1
    case dinner = 2
    case snacks = 3
}

struct CreateCustomFoodView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var nm:NavigationManager
    
    @Query private var customFoodItems:[CustomFoodData]
    
    @State var itemName:String = ""
    @State var itemCal:String = ""
    @State var itemProtein:String = ""
    @State var isMeasuredByWeight:Bool = false
    @State var isCustomFoodSaved:Bool = false
    
    private func insertDataItem(item:CustomFoodData) async {
        context.insert(item)
    }
    
    var body: some View {
        VStack {
            
            Form{
                
                Section("Details") {
                    HStack {
                        Text("Name")
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        TextField("Food Name", text: $itemName)
                    }
                    
                    HStack {
                        Text("KCAL")
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        TextField("e.g. 123", text: $itemCal)
                            .keyboardType(.numbersAndPunctuation)
                            .onReceive(itemCal.publisher.collect()) { characters in
                                let filtered = characters.filter { $0.isNumber }
                                if let numericValue = Int(String(filtered)) {
                                    itemCal = String(numericValue)
                                } else {
                                    itemCal = ""
                                }
                            }
                        
                    }
                    
                    HStack {
                        Text("Protein (g)")
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        TextField("e.g. 123", text: $itemProtein)
                            .keyboardType(.numbersAndPunctuation)
                            .onReceive(itemProtein.publisher.collect()) { characters in
                                let filtered = characters.filter { $0.isNumber }
                                if let numericValue = Int(String(filtered)) {
                                    itemProtein = String(numericValue)
                                } else {
                                    itemProtein = ""
                                }
                            }
                    }
                }
                
                Section("Add to meal occasion"){
                    HStack{
                        
                        Group {
                            
                            SubmitFoodButton(mealTitle: "Breakfast", iconWidth: 50, foodName: itemName, foodOccasion: FoodOccasions.breakfast.rawValue, calories: Int(itemCal) ?? 0, protein: Double(itemProtein) ?? 0, servingSize: "1 Serving", measuredByWeight: isMeasuredByWeight)
                            
                            Divider()
                            
                            SubmitFoodButton(mealTitle: "Lunch", iconWidth: 70, foodName: itemName, foodOccasion: FoodOccasions.lunch.rawValue, calories: Int(itemCal) ?? 0, protein: Double(itemProtein) ?? 0, servingSize: "1 Serving",measuredByWeight: isMeasuredByWeight)
                            
                            Divider()
                            
                            SubmitFoodButton(mealTitle: "Dinner", iconWidth: 60, foodName: itemName, foodOccasion: FoodOccasions.dinner.rawValue, calories: Int(itemCal) ?? 0, protein: Double(itemProtein) ?? 0, servingSize: "1 Serving",measuredByWeight: isMeasuredByWeight)
                            
                            Divider()
                            
                            SubmitFoodButton(mealTitle: "Snacks", iconWidth: 40, foodName: itemName, foodOccasion: FoodOccasions.snacks.rawValue, calories: Int(itemCal) ?? 0, protein: Double(itemProtein) ?? 0, servingSize: "1 Serving", measuredByWeight: isMeasuredByWeight)
                        }.environmentObject(nm)
                       
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(height: 120)
                    .padding([.top, .bottom],10)
                    .disabled(itemName == "" || itemCal == "" || itemProtein == "")
                    
                }
                
                HStack {
                    
                    
                    Button(action: {
                        
                        withAnimation{
                            isCustomFoodSaved = true
                        }
                        // Temp fix for saved protein being multiplied by 10 as double coverted to string multiplies by 10
                        let dataItem = CustomFoodData(name: itemName, calories: Int(itemCal) ?? 0, protein: (Double(itemProtein) ?? 0)/10)
                        Task {
                            if isCustomFoodSaved == true && customFoodItems.contains(where: {$0.name == dataItem.name && $0.calories == dataItem.calories}) == false {
                                
                                await insertDataItem(item: dataItem)
                                                                
                            }
                            
                        }
                        
                            
                    }, label: {
                        if isCustomFoodSaved {
                            HStack {
                                Text("Saved")
                                Spacer()
                                Image(systemName: "checkmark.circle")
                            }
                            .foregroundStyle(Color.green)
                        } else {
                            HStack {
                                Text("Save Custom Food")
                                Spacer()
                                Image(systemName: "bookmark.fill")
                            }
                        }
                       
                })
                //.disabled(itemName == "" || itemCal == "" || itemProtein == "")
                    
                }
                
            }
            
        }
    }
}

#Preview {
    CreateCustomFoodView()
        .environmentObject(NavigationManager())
        .modelContainer(previewContainer)
}
