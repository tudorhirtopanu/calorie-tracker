//
//  FoodItemRow.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI

struct FoodItemRow: View {
    
    let foodName: String
    let imageURL: URL
    
    @State var image:UIImage? = nil
    
    func loadImage(url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let uiImage = UIImage(data: data) {
                return uiImage
            } else {
                print("Invalid image data")
                return nil
            }
        } catch {
            print("Error loading image: \(error)")
            return nil
        }
    }
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                .stroke(Color.gray.opacity(0.15), lineWidth: 2)
                .foregroundStyle(Color.gray.opacity(0.15))
                
                
            
            VStack {
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else {
                    
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
                    //.font(.body)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 5)
                
                
                
            }
            .onAppear{
                Task {
                    await image = loadImage(url:imageURL)
                }
            }
        
        }.frame(width: 150, height: 180)
    }
}

// URL(string: "https://nix-tag-images.s3.amazonaws.com/1060_thumb.jpg")

#Preview {
        FoodItemRow(foodName: "Pizza SDFKJNBKJSDFKJ", imageURL:URL(string: "https://nix-tag-images.s3.amazonaws.com/1060_thumb.jpg")!)
}
