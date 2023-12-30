//
//  SubmitFoodButton.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 30/12/2023.
//

import SwiftUI

struct SubmitFoodButton: View {
    
    @State var mealTitle:String
    @State var iconWidth:CGFloat
    
    var body: some View {
        
        GeometryReader {geo in
            
            Button(action: {
                
                // Save Data as food item
                
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
    SubmitFoodButton(mealTitle: "Breakfast", iconWidth: 50)
}
