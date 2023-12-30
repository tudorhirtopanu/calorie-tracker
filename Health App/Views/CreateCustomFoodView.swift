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
    
    @State var itemName:String = ""
    @State var itemCal:String = ""
    @State var itemProtein:String = ""
    
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
                            .keyboardType(.namePhonePad)
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
                            .keyboardType(.namePhonePad)
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
                        
                        SubmitFoodButton(mealTitle: "Breakfast", iconWidth: 50, foodName: itemName, foodOccasion: FoodOccasions.breakfast.rawValue, calories: Int(itemCal) ?? 0, protein: Int(itemProtein) ?? 0)
                        
                        Divider()
                                                
                        SubmitFoodButton(mealTitle: "Lunch", iconWidth: 70, foodName: itemName, foodOccasion: FoodOccasions.lunch.rawValue, calories: Int(itemCal) ?? 0, protein: Int(itemProtein) ?? 0)
                        
                        Divider()
                        
                        SubmitFoodButton(mealTitle: "Dinner", iconWidth: 60, foodName: itemName, foodOccasion: FoodOccasions.dinner.rawValue, calories: Int(itemCal) ?? 0, protein: Int(itemProtein) ?? 0)
                        
                        Divider()
                        
                        SubmitFoodButton(mealTitle: "Snacks", iconWidth: 40, foodName: itemName, foodOccasion: FoodOccasions.snacks.rawValue, calories: Int(itemCal) ?? 0, protein: Int(itemProtein) ?? 0)
                       
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(height: 120)
                    .padding([.top, .bottom],10)
                    .disabled(itemName == "" || itemCal == "" || itemProtein == "")
                    
                }
                                
                Button(action: {
                    
                }, label: {
                    Text("Add Food")
                })
                
            }
            
        }
    }
}

#Preview {
    CreateCustomFoodView()
}
