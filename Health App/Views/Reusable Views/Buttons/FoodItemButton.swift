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
    
    @Binding var isEditEnabled:Bool
    
    @State var selectItem:()->Void
    
    var body: some View {
        
        Button(action: {
            
            // Turn on edit mode
            withAnimation(.spring) {
                isEditEnabled = true
            }
            
            // If item isnt in array, add it
//            if !itemsToEdit.contains(foodItem){
//                itemsToEdit.append(foodItem)
//            } else {
//                itemsToEdit.removeAll(where: { $0 == foodItem })
//            }
            selectItem()
                        
        }, label: {
            HStack{
                VStack(alignment: .leading) {
                    Text(name)
                        .multilineTextAlignment(.leading)
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
    FoodItemButton(name: "Mcdonalds McChicken Sandwich", calories: 400, protein: 25, servingSize: "1 Serving", isEditEnabled: .constant(false), selectItem: {})
        .padding(.horizontal)
        .modelContainer(previewContainer)
}
