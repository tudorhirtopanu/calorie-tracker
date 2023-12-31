//
//  FoodItemButton.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 31/12/2023.
//

import SwiftUI

struct FoodItemButton: View {
    
    @State var name:String
    @State var calories:Int
    @State var protein:Int
    
    var body: some View {
        
        Button(action: {
            
        }, label: {
            HStack{
                VStack {
                    Text(name)
                        .padding(.leading,10)
                }
                Spacer()
                HStack {
                    Text(String(calories))
                        .frame(width:50)
                    Text(String(protein))
                        .frame(width:50)
                }
            }
            .padding([.bottom, .top],1)
            .foregroundStyle(Color.primary)
        })
        
    }
}

#Preview {
    FoodItemButton(name: "Pizza", calories: 400, protein: 25)
        .padding(.horizontal)
}
