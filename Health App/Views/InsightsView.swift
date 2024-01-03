//
//  InsightsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 03/01/2024.
//

import SwiftUI
import SwiftData

struct InsightsView: View {
    
    @Query private var dailyData:[DailyNutrientData]
    @Query private var todaysData:[FoodDataItem]
    
    @Environment(\.modelContext) private var context
    
    private func returnDataItem(day:Int)->DailyNutrientData {
        return dailyData.first(where: { $0.day == day}) ?? DailyNutrientData(day: day, totalCalories: 0, totalProtein: 0)
    }
    
    private func returnDayName(day:Int) -> String {
        if day == 1 {
            return "Monday"
        } else if day == 2 {
            return "Tuesday"
        } else if day == 3 {
            return "Wednesday"
        } else if day == 4 {
            return "Thursday"
        } else if day == 5 {
            return "Friday"
        } else if day == 6 {
            return "Saturday"
        } else if day == 7 {
            return "Sunday"
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
    
    private func calculateCalories(itemArray:[FoodDataItem]) -> Int {
        
        let totalCalories = itemArray.reduce(0) { $0 + $1.calories }
        
        return totalCalories
    }
    
    @State var arrayOfDays:[Int] = [1,2, 3, 4, 5, 6, 7]
    @State var currentDay = Calendar.current.component(.day, from: Date())
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        
        List {
            
            Button(action: {
                deleteData()
            }, label: {
                Text("Delete Data")
            })
            
            Text("Total Data Items "+String(dailyData.count))
            
            Text("Day is \(returnDayName(day:currentDay)) -> \(String(currentDay))")
            
            ForEach(dailyData){d in
                Text(String(d.day))
            }
            
            Section {
                VStack(alignment: .leading){
                    
                    ForEach(arrayOfDays, id: \.self) {day in
                        let dayData = returnDataItem(day: day)
                        //let day = todaysData.first.day
                        
                        HStack {
                            Text(returnDayName(day:day))
                                .frame(width:100)
                            
                            if dayData.day == currentDay{
                                Text(String(calculateCalories(itemArray: todaysData)))
                            }else {
                                Text(String(dayData.totalCalories))
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
        }.onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                currentDay = Calendar.current.component(.day, from: Date())
            }
        })
                   
        
    }
    
}

#Preview {
    InsightsView()
        .modelContainer(previewContainer)
}
