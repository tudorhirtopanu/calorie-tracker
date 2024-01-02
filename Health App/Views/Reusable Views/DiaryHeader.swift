//
//  DiaryHeader.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 02/01/2024.
//

import SwiftUI

struct DiaryHeader: View {
    
    @State var mealTime:String
    @State var mealCalories:Int
    @State var mealProtein:Double
    
    @State var spacingCondition:Bool
    
    var body: some View {
        HStack {
            Text(mealTime)
                .fontWeight(.semibold)
                .padding(.leading,10)
            Spacer()
            Text(String(mealCalories))
                .fontWeight(.semibold)
                .frame(width:50)
            Text(String(mealProtein))
                .fontWeight(.semibold)
                .frame(width:50)
            
        }
        .overlay(content: {
            RoundedRectangle(cornerSize: CGSize( width: 20, height: 20))
                .foregroundStyle(Color.gray.opacity(0.2))
                .frame(height: 40)
        })
        .padding(.top)
        .padding(.bottom, spacingCondition ? 0 : 10)
    }
}

#Preview {
    DiaryHeader(mealTime: "Lunch", mealCalories: 200, mealProtein: 10, spacingCondition: true)
}
