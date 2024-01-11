//
//  CustomBrandFoodsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 01/01/2024.
//

import SwiftUI

struct CustomBrandFoodsView: View {
        
    @State var selectedFood:[Food] = []
    @State private var searchText:String = ""
    var fileToDecode:String
    var image:String
    
    @EnvironmentObject var nm:NavigationManager
    
    private var searchResults:[Food] {
        
        if searchText.isEmpty {
            return selectedFood
        } else {
            return selectedFood.filter {
                            $0.name.range(of: searchText, options: .caseInsensitive) != nil
                        }
        }
        
    }
    
    var body: some View {
        VStack {
            
            ZStack {
                
                RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                    .foregroundStyle(Color.gray.opacity(0.15))
                    .frame(height: 40)
                
                HStack {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.gray)
                    TextField("Search for food ...", text: $searchText)
                        //.focused($searchIsFocused)
                }
                .padding(8)
            }
            .padding()
            
            List {
                
                Section {
                    HStack {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:100)
                        
                        HStack {
                            Spacer()
                            Text("\(fileToDecode) Menu")
                            Spacer()
                        }
                    }
                }
                
                ForEach(searchResults){food in
                    
                    NavigationLink(destination: AddFoodView(foodItem: food, preWrittenFood: true).environmentObject(nm), label: {
                        Text(food.name)
                    })
                    
                    
                }
            }
        }.onAppear{
            selectedFood = JSONHandler.decodeJSON([Food].self, fileName: fileToDecode)
        }
    }
}

#Preview {
    NavigationStack {
        CustomBrandFoodsView(fileToDecode: "Mcdonalds", image: "McdonaldsLogo")
            .environmentObject(NavigationManager())
    }
}
