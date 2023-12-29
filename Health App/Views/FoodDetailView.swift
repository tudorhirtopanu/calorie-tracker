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
    
    var body: some View {
        VStack{
            Text(text)
        }
        .onAppear{
            Task {
                await NutritionixService.shared.fetchItemInfo(itemId: itemId)
            }
            print("passed in "+text)
        }
    }
}

//#Preview {
//    FoodDetailView(text: "TEST")
//}
