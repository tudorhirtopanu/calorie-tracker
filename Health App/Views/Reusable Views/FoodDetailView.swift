//
//  FoodDetailView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI

struct FoodDetailView: View {
    
    @State var text:String
    @State var itemId:String
    
    @State var foodItem:Food?
    
    @EnvironmentObject var nm:NavigationManager
    
    @State var showFoodView:Bool = false
    
    func populateData(name:String, calories:Int, protein:Double, weight:Double) async -> Food {
        return Food(id: 11, name: name, measuredByWeight: true, servingSizes: [ServingSizes(id: 12, name: "1 serving Size", weight: weight, calories: calories, protein: protein)])
    }
    
    var body: some View {
        VStack{
            if showFoodView {
                AddFoodView(foodItem: foodItem!)
                    .environmentObject(nm)
            } else {
                ProgressView()
            }
        }
        .onAppear{
            
            Task {
                let specificItem = try await NutritionixService.shared.fetchItemInfo(itemId: itemId)
                
                foodItem = await populateData(name: specificItem.food_name, calories: specificItem.nf_calories, protein: Double(specificItem.nf_protein), weight: Double(specificItem.serving_weight_grams))
                
                showFoodView = true
                
                //print(specificItem.food_name)
                
//                foodItem.name = specificItem.food_name
//                
//                foodServingSize.calories = specificItem.nf_calories
//                foodServingSize.name = "1 serving Size"
//                foodServingSize.protein = Double(specificItem.nf_protein)
//                foodServingSize.weight = Double(specificItem.serving_weight_grams)
//                
//                foodItem.servingSizes.append(foodServingSize)
                
            }
        }
    }
}

//#Preview {
//    FoodDetailView(text: "TEST")
//}
