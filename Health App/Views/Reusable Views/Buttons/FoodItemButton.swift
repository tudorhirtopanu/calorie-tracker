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
    @State var protein:Double
    @State var servingSize:String
    
    var body: some View {
        
        Button(action: {
            
        }, label: {
            HStack{
                VStack(alignment: .leading) {
                    Text(name)
                        .padding(.leading,10)
                    Text(servingSize)
                        .padding(.leading,10)
                        .font(Font.system(size: 14))
                        .foregroundStyle(Color.gray)
                    
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
    FoodItemButton(name: "Pizza", calories: 400, protein: 25, servingSize: "1 Serving")
        .padding(.horizontal)
}
