//
//  AddFoodView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import SwiftUI

struct AddFoodView: View {
    
    @State var foodItem:Food
    @State var selectedServing:ServingSizes?
    
     @State var itemName:String = ""
     @State var itemCal:Int = -1
     @State var itemProtein:Double = -1
    
    var body: some View {
        ZStack {
            
            Color(UIColor.secondarySystemBackground).ignoresSafeArea()
            VStack {
                
                VStack{
                    
                    Image("McdonaldsLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding([.top, .bottom])
                    
                    Text(foodItem.name)
                        .font(.title3)
                }
                            
                Form {
                    
                    Section(content: {
                        ForEach(foodItem.servingSizes){s in
                            
                            Button(action: {
                                selectedServing = s
                                itemName = foodItem.name
                                itemCal = s.calories
                                itemProtein = s.protein
                            }, label: {
                                HStack {
                                    Text(s.name + " (\(String(Int(s.weight)))g)")
                                    Spacer()
                                    Text(String(s.calories))
                                        .frame(width:40)
                                    Text(String(s.protein))
                                        .frame(width:40)
                                    
                                    if selectedServing?.id == s.id {
                                        Image(systemName: "checkmark.circle.fill")
                                            .frame(width:20)
                                            .foregroundStyle(Color.accentColor)
                                    } else {
                                        Image(systemName: "circle")
                                            .frame(width:20)
                                            .fontWeight(.thin)
                                    }
                                    
                                    
                                }
                            })
                            .foregroundStyle(.black)
                           
                        }
                        
                    }, header: {
                        HStack {
                            Text("Serving Sizes")
                            
                            Spacer()
                            
                            Text("KCAL")
                                .frame(width:40)
                            Text("PROT")
                                .frame(width:40)
                            Text("d")
                                .opacity(0)
                                .frame(width:20)
                        }
                    })
                    
                    Section("Add to meal occasion"){
                        HStack{
                            
                            SubmitFoodButton(mealTitle: "Breakfast", iconWidth: 50, foodName: itemName, foodOccasion: FoodOccasions.breakfast.rawValue, calories: itemCal, protein: itemProtein)

                            Divider()
                                                    
                            SubmitFoodButton(mealTitle: "Lunch", iconWidth: 70, foodName: itemName, foodOccasion: FoodOccasions.lunch.rawValue, calories: itemCal, protein: itemProtein)
                            
                            Divider()
                            
                            SubmitFoodButton(mealTitle: "Dinner", iconWidth: 60, foodName: itemName, foodOccasion: FoodOccasions.dinner.rawValue, calories: itemCal, protein: itemProtein)
                            
                            Divider()
                            
                            SubmitFoodButton(mealTitle: "Snacks", iconWidth: 40, foodName: itemName, foodOccasion: FoodOccasions.snacks.rawValue, calories: itemCal, protein: itemProtein)
                           
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(height: 120)
                        .padding([.top, .bottom],10)
                        .disabled(itemName == "" || itemCal == -1 || itemProtein == -1)
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    AddFoodView(foodItem: Food(id: 0, name: "Mcdonald's Fries", servingSizes: [ServingSizes(id: 0, name: "Small", weight: 80, calories: 236, protein: 2.3), ServingSizes(id: 1, name: "Medium", weight: 114, calories: 337, protein: 3.3), ServingSizes(id: 2, name: "Large", weight: 150, calories: 445, protein: 4.4)]))
}
