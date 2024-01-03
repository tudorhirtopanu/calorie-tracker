//
//  InsightsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 02/01/2024.
//

import SwiftUI
import SwiftData

struct InsightsView: View {
    
    // TODO: Delete all daily data at the end of the week
    
    @Query private var dailyData:[DailyNutrientData]
    
    @Environment(\.modelContext) private var context
    
    private func returnDataItem(day:Int)->DailyNutrientData {
        return dailyData.first(where: { $0.day == day}) ?? DailyNutrientData(day: day, totalCalories: 0, totalProtein: 0)
    }
    
    private func returnDayName(day:Int) -> String {
        if day == 1 {
            return "Sunday"
        } else if day == 2 {
            return "Monday"
        } else if day == 3 {
            return "Tuesday"
        } else if day == 4 {
            return "Wednesday"
        } else if day == 5 {
            return "Thursday"
        } else if day == 6 {
            return "Friday"
        } else if day == 7 {
            return "Saturday"
        } else {
            return "Unknown"
        }
    }
    
    private func deleteData() {
        
        do {
            try context.delete(model: DailyNutrientData.self)
        }
        catch {
           print("failed to delete model")
        }
        
    }
    
    @State var arrayOfDays:[Int] = [2, 3, 4, 5, 6, 7, 1]
    
    var body: some View {
        List {
            
            Button(action: {
                deleteData()
            }, label: {
                Text("Delete Data")
            })
            
            Text("Total Data Items "+String(dailyData.count))
            
            ForEach(dailyData){d in
                Text(String(d.day))
            }
            
            Section {
                VStack(alignment: .leading){
                    
                    ForEach(arrayOfDays, id: \.self) {day in
                        let dayData = returnDataItem(day: day)
                        
                        HStack {
                            Text(returnDayName(day:day))
                                .frame(width:100)
                            
                                
                            Text(String(dayData.totalCalories))
                            
                        }
                        
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    InsightsView()
        .modelContainer(previewContainer2)
}
