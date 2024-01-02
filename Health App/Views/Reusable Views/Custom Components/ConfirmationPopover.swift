//
//  ConfirmationPopover.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 02/01/2024.
//

import SwiftUI

struct ConfirmationPopover: View {
    var body: some View {
        
        HStack {
            Image(systemName: "checkmark.circle")
            Text("Food Added")
        }
//        .background(.thinMaterial, in: RoundedRectangle(cornerSize: CGSize(5), style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .padding()
        .background(.gray.opacity(0.25), in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
        
    }
}

#Preview {
    ConfirmationPopover()
}
