//
//  SettingsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 11/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("CalorieGoal") var calorieGoal:Int = 2999
    @AppStorage("ProteinGoal") var proteinGoal:Double = 120
    
    @State private var calorieTextfield = ""
    @State private var proteinTextfield = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            VStack {
                
                HStack {
                    Text("Calorie Goal")
                        .fontWeight(.medium)
                        .font(Font.system(size: 12))
                    
                    Spacer()
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                        .foregroundStyle(Color.gray.opacity(0.15))
                        .frame(height: 40)
                    
                    HStack {
                            
                        TextField("e.g. 2300", text: $calorieTextfield)
                            .onReceive(calorieTextfield.publisher.collect()) { characters in
                                let filtered = characters.filter { $0.isNumber }
                                if let numericValue = Int(String(filtered)) {
                                    calorieTextfield = String(numericValue)
                                } else {
                                    calorieTextfield = ""
                                }
                            }
                    }
                    .padding(8)
                }
                .padding(.bottom, 10)
            }
            
            VStack {
                
                HStack {
                    Text("Protein Goal")
                        .fontWeight(.medium)
                        .font(Font.system(size: 12))
                    
                    Spacer()
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                        .foregroundStyle(Color.gray.opacity(0.15))
                        .frame(height: 40)
                    
                    HStack {

                        TextField("e.g. 130", text: $proteinTextfield)
                            .onReceive(proteinTextfield.publisher.collect()) { characters in
                                let filtered = characters.filter { $0.isNumber }
                                if let numericValue = Int(String(filtered)) {
                                    proteinTextfield = String(numericValue)
                                } else {
                                    proteinTextfield = ""
                                }
                            }
                    }
                    .padding(8)
                }
            }
            .padding(.bottom, 10)
            
            Button(action: {
                UserDefaults.standard.setValue(Int(calorieTextfield), forKey: "CalorieGoal")
                UserDefaults.standard.setValue(Double(proteinTextfield), forKey: "ProteinGoal")
                
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Set Targets")
            })
            .padding(10)
            .foregroundStyle(.white)
            .background(content: {
                RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                    .foregroundStyle(Color.accentColor)
            })
            .disabled(calorieTextfield == "" || proteinTextfield == "")

        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsView()
}
