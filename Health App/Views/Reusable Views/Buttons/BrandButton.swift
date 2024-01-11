//
//  BrandButton.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import SwiftUI

struct CustomValue2:Hashable {
    let test:String
}

struct BBLabel: Hashable {
    let fileName:String
    let image:String
}

struct BrandButton: View {
    
    var fileName:String
    var image:String
    var brandName:String
    
    
    
    @EnvironmentObject var nm:NavigationManager
    
    var body: some View {
        
        /* parameters to pass in
         - file name
         */
        
        NavigationLink(value: BBLabel(fileName: fileName, image: image), label: {
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
