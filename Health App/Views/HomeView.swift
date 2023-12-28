//
//  ContentView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 28/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var textField: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search for food ...", text: $textField)
                .padding(15)
                .overlay {
                    RoundedRectangle(cornerSize: CGSize( width: 10, height: 10))
                        .stroke(Color.gray, lineWidth: 1)
                }
            
            Button(action: {
                print(textField)
            }, label: {
                Text("Search")
            })
            .padding(.top, 10)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
