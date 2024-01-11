//
//  CustomBrandFoodsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import SwiftUI

struct CustomBrandFoodsView: View {
        
    @State var selectedFood:[Food] = []
    var fileToDecode:String
    var image:String
    
    @EnvironmentObject var nm:NavigationManager
    
    var body: some View {
        VStack {
            List {
                
                Section {
                    HStack {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:100)
                        
                        HStack {
                            Spacer()
                            Text("\(fileToDecode) Menu")
                            Spacer()
                        }
                    }
                }
                
                ForEach(selectedFood){food in
                    
                    NavigationLink(destination: AddFoodView(foodItem: food, preWrittenFood: true).environmentObject(nm), label: {
                        Text(food.name)
                    })
                    
                    
                }
            }
        }.onAppear{
            selectedFood = JSONHandler.decodeJSON([Food].self, fileName: fileToDecode)
        }
    }
}

#Preview {
    NavigationStack {
        CustomBrandFoodsView(fileToDecode: "Mcdonalds", image: "McdonaldsLogo")
            .environmentObject(NavigationManager())
    }
}
