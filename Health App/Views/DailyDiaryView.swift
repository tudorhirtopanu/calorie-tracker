//
//  DailyDiaryView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 29/12/2023.
//

import SwiftUI
import SwiftData

struct DailyDiaryView: View {
        
    @Query private var items:[FoodDataItem]
    
    var body: some View {
        VStack {
            Text("Daily Diary")
            
            List(items) { item in
                HStack{
                    Text(item.name)
                    Text(String(item.calories))
                }
            }
            
        }
    }
}

#Preview {
    DailyDiaryView()
}
