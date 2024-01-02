//
//  FoodSelectionOverlay.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 02/01/2024.
//

import SwiftUI

struct FoodSelectionOverlay: View {
    
    @State var deleteItems:()->Void
    
    var body: some View {
        ZStack {
            
            Color.gray.opacity(0.15).ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Selected Items")
                HStack {
                    
                    Button(action: {
                        deleteItems()
                    }, label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width:25, height: 25)
                            .foregroundStyle(.white)
                    })
                    .padding(15)
                    .background(.gray.opacity(0.45), in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    
                }
            }
        }
    }
}

#Preview {
    FoodSelectionOverlay(deleteItems: {})
        
}
