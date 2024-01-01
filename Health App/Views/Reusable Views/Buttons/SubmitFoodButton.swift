//
//  SubmitFoodButton.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 30/12/2023.
//

import SwiftUI
import SwiftData

struct SubmitFoodButton: View {
    
    @Environment(\.modelContext) private var context
    
    @State var mealTitle:String
    @State var iconWidth:CGFloat
    
    var foodName:String
    var foodOccasion:Int
    var calories:Int
    var protein:Double
    
    var body: some View {
        
        GeometryReader {geo in
            
            Button(action: {
                
                //TODO: Ensure button can only be pressed once
                
                // Save Data as food item
               let data = FoodDataItem(name: foodName, foodOccasion: foodOccasion, calories: calories, protein: protein)
                
                context.insert(data)
                
            }, label: {
                VStack{
                    Image(mealTitle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconWidth, height: 70)
                    Text(mealTitle)
                        .font(Font.system(size: 14))
                    Image(systemName: "plus.circle.fill")
                        .font(Font.system(size: 22))
                        .padding([.top, .bottom], 5)
                }
            })
            .foregroundStyle(Color.black)
            .frame(width: geo.size.width, height: geo.size.height)
            
        }
        
    }
}

#Preview {
    SubmitFoodButton(mealTitle: "Breakfast", iconWidth: 50, foodName: "Pizza", foodOccasion: 1, calories: 220, protein: 20)
}
