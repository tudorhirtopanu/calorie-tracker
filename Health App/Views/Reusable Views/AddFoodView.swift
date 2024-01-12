//
//  AddFoodView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//
// 108456.11121 is the default number representing that there is no weight

import SwiftUI

struct AddFoodView: View {
    
    @State var foodItem:Food
    @State var selectedServing:ServingSizes?
    
    @State var itemName:String = ""
    @State var itemCal:Int = -1
    @State var itemProtein:Double = -1
    @State var servingSize:String = ""
    @State var isMeasuredByWeight:Bool = false
    @State var preWrittenFood:Bool
    
    @State var customPortionText = ""
    @FocusState var customIsFocused:Bool
    
    @State var customCal:Int?
    @State var customProtein:Double?
    
    @EnvironmentObject var nm:NavigationManager
    
    private func truncateDouble(number: Double, decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return Double(Int(number * multiplier)) / multiplier
    }
    
    func calculateCustomCalories(newWeight:Int) -> Int {
        
        let baseServing = foodItem.servingSizes.first!
                
        let multiplier = Double(baseServing.calories)/baseServing.weight
        
        let newCalories = Double(newWeight)*multiplier

        return Int(newCalories)
        
    }
    
    func calculateCustomProtein(newWeight:Int) -> Double {
        
        let baseServing = foodItem.servingSizes.first!
        
        print(baseServing.weight)
        
        let multiplier = Double(baseServing.protein)/baseServing.weight
        
        let newProtein = Double(newWeight)*multiplier
        
        let truncatedNum = truncateDouble(number: newProtein, decimalPlaces: 1)
        
        return truncatedNum
        
    }
    
    func returnMeasurement(food:Food) -> String {
        
        if food.name.contains("Milk") || food.name.contains("Cola") {
            return "ml"
        } else {
            return "g"
        }
        
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                
                
                            
                Form {
                    
                    Section {
                        HStack {
                            Spacer()
                            VStack{
                                
                                if preWrittenFood {
                                    Image(foodItem.image?.absoluteString ?? "McdonaldsLogo" )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                        .padding([.top, .bottom])
                                }else {
                                    AsyncImage(url: foodItem.image) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 200)
                                                        .padding([.top, .bottom])
                                                case .failure:
                                                    Image(systemName: "McdonaldsLogo") // Show a placeholder or error image on failure
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 200)
                                                        .padding([.top, .bottom])
                                                @unknown default:
                                                    fatalError("Unhandled case, update switch statement")
                                                }
                                            }
                                }
                                
                                
                                
                                
                                
                                Text(foodItem.name)
                                    .font(.title3)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    Section(content: {
                        ForEach(foodItem.servingSizes){s in
                            
                            Button(action: {
                                selectedServing = s
                                itemName = foodItem.name
                                itemCal = s.calories
                                itemProtein = s.protein
                                servingSize = s.name
                                isMeasuredByWeight = foodItem.measuredByWeight
                            }, label: {
                                HStack {
                                    if s.weight == 108456.11121 {
                                        Text(s.name)
                                    }else {
                                        Text(s.name + " (\(String(Int(s.weight)))\(returnMeasurement(food: foodItem)))")
                                    }
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
                            .foregroundStyle(Color.primary)
                           
                        }
                        
                       
                        
                        
                        
                        // If food is measured by item
                        
                        
                        
                        // If food is measured by weight and weight is not empty
                        if foodItem.measuredByWeight == true && foodItem.servingSizes.first!.weight != 108456.11121 {
                            // Custom size
                            HStack {
                                TextField("Add custom weight", text: $customPortionText)
                                    .keyboardType(.numbersAndPunctuation)
                                    .submitLabel(.done)
                                    .onReceive(customPortionText.publisher.collect()) { characters in
                                        let filtered = characters.filter { $0.isNumber }
                                        if let numericValue = Int(String(filtered)) {
                                            customPortionText = String(numericValue)
                                        } else {
                                            customPortionText = ""
                                        }
                                    }
                                    .focused($customIsFocused)
                                    .onSubmit {
                                        if customPortionText != "" {
                                            customCal = calculateCustomCalories(newWeight: Int(customPortionText) ?? 888)
                                            customProtein = calculateCustomProtein(newWeight: Int(customPortionText) ?? 888  )
                                            
                                            selectedServing = ServingSizes(id: 987, name: "Custom Serving \(Int(customPortionText) ?? 888)\(returnMeasurement(food: foodItem))", weight: Double(customPortionText)!, calories: customCal!, protein: customProtein ?? 10.10)
                                        } else {
                                            selectedServing = nil
                                            customCal = nil
                                            customProtein = nil
                                        }
                                    }
                                if let customCal = customCal {
                                    Text(String(customCal))
                                        .frame(width:40)
                                }
                                
                                if let customProtein = customProtein {
                                    Text(String(customProtein))
                                        .frame(width:40)
                                }
                                
                                if selectedServing?.id == 987 {
                                    Image(systemName: "checkmark.circle.fill")
                                        .frame(width:20)
                                        .foregroundStyle(Color.accentColor)
                                } else {
                                    
                                    Image(systemName: "circle")
                                        .frame(width:20)
                                        .fontWeight(.thin)
                                }
                                
                            }
                        } else {
                            HStack{
                                TextField("Enter item number", text: $customPortionText)
                                    .keyboardType(.numbersAndPunctuation)
                                    .submitLabel(.done)
                                    .onReceive(customPortionText.publisher.collect()) { characters in
                                        let filtered = characters.filter { $0.isNumber }
                                        if let numericValue = Int(String(filtered)) {
                                            customPortionText = String(numericValue)
                                        } else {
                                            customPortionText = ""
                                        }
                                    }
                                    .focused($customIsFocused)
                                    .onSubmit {
                                        if customPortionText != "" {
                                            customCal = foodItem.servingSizes.first!.calories * Int(customPortionText)!
                                            customProtein = foodItem.servingSizes.first!.protein * Double(Int(customPortionText)!)
                                            
                                            selectedServing = ServingSizes(id: 987, name: "\(foodItem.name) x\(customPortionText)", weight: Double(customPortionText)!, calories: customCal!, protein: customProtein ?? 10.10)
                                        } else {
                                            selectedServing = nil
                                            customCal = nil
                                            customProtein = nil
                                        }
                                    }
                                
                                if let customCal = customCal {
                                    Text(String(customCal))
                                        .frame(width:40)
                                }
                                
                                if let customProtein = customProtein {
                                    Text(String(customProtein))
                                        .frame(width:40)
                                }
                                
                                if selectedServing?.id == 987 {
                                    Image(systemName: "checkmark.circle.fill")
                                        .frame(width:20)
                                        .foregroundStyle(Color.accentColor)
                                } else {
                                    
                                    Image(systemName: "circle")
                                        .frame(width:20)
                                        .fontWeight(.thin)
                                }
                            }
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
                            Group{
                                SubmitFoodButton(mealTitle: "Breakfast", iconWidth: 50, foodName: foodItem.name, foodOccasion: FoodOccasions.breakfast.rawValue, calories: selectedServing?.calories ?? 0, protein: selectedServing?.protein ?? 0, servingSize: selectedServing?.name ?? "Unknown", measuredByWeight: isMeasuredByWeight)
                                
                                Divider()
                                
                                SubmitFoodButton(mealTitle: "Lunch", iconWidth: 70, foodName: foodItem.name, foodOccasion: FoodOccasions.lunch.rawValue, calories: selectedServing?.calories ?? 0, protein: selectedServing?.protein ?? 0, servingSize: selectedServing?.name ?? "Unknown",measuredByWeight: isMeasuredByWeight)
                                
                                Divider()
                                
                                SubmitFoodButton(mealTitle: "Dinner", iconWidth: 60, foodName: foodItem.name, foodOccasion: FoodOccasions.dinner.rawValue, calories: selectedServing?.calories ?? 0, protein: selectedServing?.protein ?? 0, servingSize: selectedServing?.name ?? "Unknown",measuredByWeight: isMeasuredByWeight)
                                
                                Divider()
                                
                                SubmitFoodButton(mealTitle: "Snacks", iconWidth: 40, foodName: foodItem.name, foodOccasion: FoodOccasions.snacks.rawValue, calories: selectedServing?.calories ?? 0, protein: selectedServing?.protein ?? 0, servingSize: selectedServing?.name ?? "Unknown",measuredByWeight: isMeasuredByWeight)
                            }
                            .environmentObject(nm)
                           
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(height: 120)
                        .padding([.top, .bottom],10)
                        .disabled(
                            selectedServing == nil
                        )
                        
                    }
                    
                }
            }
        }
    }
}

#Preview {
    AddFoodView(foodItem: Food(id: 0, name: "Mcdonald's Fries", image: AssetURL.url(for: "McdonaldsLogo"), measuredByWeight: false, servingSizes: [ServingSizes(id: 0, name: "Small", weight: 80, calories: 236, protein: 2.3), ServingSizes(id: 1, name: "Medium", weight: 114, calories: 337, protein: 3.3), ServingSizes(id: 2, name: "Large", weight: 150, calories: 445, protein: 4.4)]), preWrittenFood: false)
        .environmentObject(NavigationManager())
}
