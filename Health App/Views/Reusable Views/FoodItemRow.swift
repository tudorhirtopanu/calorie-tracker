//
//  FoodItemRow.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI

struct FoodItemRow: View {
    
    let foodName: String
    let imageURL: URL?
    
    var body: some View {
        HStack {
            
            if let imageURL = imageURL,
               let imageData = try? Data(contentsOf: imageURL),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            else {

                ZStack {
                    Color.gray
                        .frame(width: 100, height: 100)
                        .opacity(0.35)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }
                
            }
            
            Text(foodName)
                .font(.headline)
                .padding(.top, 5)
            
        }
    }
}

// URL(string: "https://nix-tag-images.s3.amazonaws.com/1060_thumb.jpg")

#Preview {
    FoodItemRow(foodName: "Pizza", imageURL: URL(string: "https://nix-tag-images.s3.amazonaws.com/1060_thumb.jpg"))
}
