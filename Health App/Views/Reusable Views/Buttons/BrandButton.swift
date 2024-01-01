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
    
    private struct CustomValue2:Hashable {
        let test:Int
    }
    
    @EnvironmentObject var nm:NavigationManager
    
    var body: some View {
        
        /* parameters to pass in
         - file name
         */
        
        NavigationLink(value: CustomValue2(test: 1), label: {
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
        .navigationDestination(for: CustomValue2.self, destination: { state in
            CustomBrandFoodsView(fileToDecode: fileName)
                .environmentObject(nm)
        })
        
//        NavigationLink(destination: CustomBrandFoodsView(fileToDecode: fileName),
//                       label: {
//
//                VStack {
//                    Image(image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width:70, height: 70)
//                    
//                    Text(brandName)
//                        .font(Font.system(size: 18, weight: .medium))
//                        .foregroundStyle(Color.primary)
//                }
//            
//        })
        
    }
}

#Preview {
    NavigationStack {
        BrandButton(fileName: "Mcdonalds", image: "McdonaldsLogo", brandName: "Mcdonalds")
    }
}
