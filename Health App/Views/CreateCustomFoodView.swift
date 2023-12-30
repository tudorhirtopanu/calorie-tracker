//
//  CreateCustomFoodView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 30/12/2023.
//

import SwiftUI

struct CreateCustomFoodView: View {
    
    @State var itemName:String = ""
    @State var itemCal:String = ""
    @State var itemProtein:String = ""
    
    var body: some View {
        VStack {
            
            Form{
                
                Section("Details") {
                    HStack {
                        Text("Name")
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        TextField("Food Name", text: $itemName)
                    }
                    
                    HStack {
                        Text("KCAL")
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        TextField("e.g. 123", text: $itemCal)
                    }
                    
                    HStack {
                        Text("Protein (g)")
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        TextField("e.g. 123", text: $itemProtein)
                    }
                }
                
                Section("Add to meal occasion"){
                    HStack{
                        VStack{
                            Image("Breakfast")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 70)
                            Text("Breakfast")
                                .font(Font.system(size: 14))
                            Image(systemName: "plus.circle.fill")
                                .font(Font.system(size: 18))
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width:80)
                        VStack{
                            Image("Lunch")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            Text("Lunch")
                                .font(Font.system(size: 14))
                            Image(systemName: "plus.circle.fill")
                                .font(Font.system(size: 18))
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width:80)
                        VStack{
                            Image("Dinner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 70)
                            Text("Dinner")
                                .font(Font.system(size: 14))
                            Image(systemName: "plus.circle.fill")
                                .font(Font.system(size: 18))
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width:80)
                        VStack{
                            Image("Snacks")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 70)
                            Text("Snacks")
                                .font(Font.system(size: 14))
                            Image(systemName: "plus.circle.fill")
                                .font(Font.system(size: 18))
                                .padding([.top, .bottom], 5)
                        }
                        .frame(width:80)
                    }
                    
                }
                
                Button(action: {
                    
                }, label: {
                    Text("Add Food")
                })
                
            }
            
        }
    }
}

#Preview {
    CreateCustomFoodView()
}
