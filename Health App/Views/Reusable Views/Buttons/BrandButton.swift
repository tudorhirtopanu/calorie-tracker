//
//  BrandButton.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import SwiftUI

struct BrandButton: View {
    
    var fileName:String
    var image:String
    var brandName:String
    
    var body: some View {
        
        /* parameters to pass in
         - file name
         */
        
        NavigationLink(destination: CustomBrandFoodsView(fileToDecode: fileName),
                       label: {

                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width:70, height: 70)
                    
                    Text(brandName)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.primary)
                }
            
        })
        
    }
}

#Preview {
    NavigationStack {
        BrandButton(fileName: "Mcdonalds", image: "McdonaldsLogo", brandName: "Mcdonalds")
    }
}
