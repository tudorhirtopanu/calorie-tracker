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
    
    @State private var errorMessage: String?
    
    func populateData(name:String, calories:Int, protein:Double, weight:Double, servingSizeName:String, imageURL:URL) async -> Food {
        return Food(id: 11, name: name, image: imageURL, measuredByWeight: true, servingSizes: [ServingSizes(id: 12, name: servingSizeName, weight: weight, calories: calories, protein: protein)])
    }
    
    var body: some View {
        VStack{
            if showFoodView {
                AddFoodView(foodItem: foodItem!, preWrittenFood: false)
                    .environmentObject(nm)
            } else {
                ProgressView()
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                }
            }
        }
        .onAppear{
            
            Task {
                do {
                    let specificItem = try await NutritionixService.shared.fetchItemInfo(itemId: itemId)
                    
                    foodItem = await populateData(name: specificItem.food_name, calories: Int(Double(specificItem.nf_calories)), protein: Double(specificItem.nf_protein ?? 0), weight: Double(specificItem.serving_weight_grams ?? 108456.11121), servingSizeName: String(specificItem.serving_qty ?? 1)+" "+(specificItem.serving_unit ?? "unknown"), imageURL: specificItem.photo.thumb)
                    
                    showFoodView = true
                } catch {
                    errorMessage = "The daily limit for this api has been reached"
                }
                
                
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
