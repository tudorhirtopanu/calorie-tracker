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
    
    @EnvironmentObject var nm:NavigationManager
    
    var body: some View {
        VStack {
            List {
                
                Section {
                    HStack {
                        Image("McdonaldsLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width:100)
                        
                        HStack {
                            Spacer()
                            Text("Mcdonalds Menu")
                            Spacer()
                        }
                    }
                }
                
                ForEach(selectedFood){food in
                    
                    NavigationLink(destination: AddFoodView(foodItem: food).environmentObject(nm), label: {
                        Text(food.name)
                    })
                    
                    
                }
            }
        }.onAppear{
            // TODO: Load JSON
            selectedFood = JSONHandler.decodeJSON([Food].self, fileName: fileToDecode)
        }
    }
}

#Preview {
    NavigationStack {
        CustomBrandFoodsView(fileToDecode: "Mcdonalds")
            .environmentObject(NavigationManager())
    }
}
