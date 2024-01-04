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
    
    private func isDateInCurrentWeek(_ date:Date) -> Bool {
        var calendar = Calendar.current
        var currentDate = Date()
        
        //calendar.firstWeekday = 2
        
        
        let currentWeek = calendar.component(.weekOfYear, from: currentDate)
        let targetWeek = calendar.component(.weekOfYear, from: date)
        
        return currentWeek == targetWeek
    }
    
//    private func isDateInCurrentWeek(_ date: Date) -> Bool {
//        var calendar = Calendar.current
//        calendar.firstWeekday = 2
//
//        let currentDate = Date()
//        let currentWeekday = calendar.component(.weekday, from: currentDate)
//        let targetWeekday = calendar.component(.weekday, from: date)
//
//        if currentWeekday == 1 { // If today is Sunday
//            let currentWeek = calendar.component(.weekOfYear, from: currentDate)
//            let targetWeek = calendar.component(.weekOfYear, from: date)
//
//            return targetWeek == currentWeek || (targetWeek == currentWeek - 1 && targetWeekday != 1)
//        } else {
//            let currentWeek = calendar.component(.weekOfYear, from: currentDate)
//            let targetWeek = calendar.component(.weekOfYear, from: date)
//
//            return currentWeek == targetWeek
//        }
//    }
    
    @State var arrayOfDays:[Int] = [2, 3, 4, 5, 6, 7, 1]
    @State var currentDay = Calendar.current.component(.weekday, from: Date())
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var dtm = DailyTaskManager()
    
    func getDayOfMonthForDate(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekday], from: date)
        
        guard let firstDayOfMonth = calendar.date(from: components) else {
            return 0
        }
        
        let daysDifference = calendar.dateComponents([.day], from: firstDayOfMonth, to: date).day ?? 0
        return daysDifference + 1
    }
    
    var body: some View {
        
        List {
            
            Button(action: {
                deleteData()
            }, label: {
                Text("Delete Data")
            })
            
            Text("Total Data Items "+String(dailyData.count))
            
            Text("Day is \(returnDayName(day:dtm.adjustedWeekday(weekday: currentDay))) -> \(String(dtm.adjustedWeekday(weekday: currentDay)))")
            
            ForEach(dailyData){d in
                Text(String(d.day))
            }
            let lastActiveDayOld = Calendar.current.component(.day, from: Date())
            Text("Day of month: \(getDayOfMonthForDate(Date()))")
            
            Section {
                VStack(alignment: .leading){
                    
                    ForEach(arrayOfDays, id: \.self) {day in
                        let dayData = returnDataItem(day: dtm.adjustedWeekday(weekday: day))
                        //let day = todaysData.first.day
                        
                        HStack {
                            Text(returnDayName(day:dtm.adjustedWeekday(weekday: day)))
                                .frame(width:100)
                            
                            if dayData.day == dtm.adjustedWeekday(weekday: currentDay){
                                Text(String(calculateCalories(itemArray: todaysData)))
                            }else {
                                if isDateInCurrentWeek(dayData.creationDate){
                                    Text(String(dayData.totalCalories))
                                }else {
                                    Text(String(00))
                                }
                            }
                            
                            Button(action: {
                                print(isDateInCurrentWeek(dayData.creationDate))
                            }, label: {
                                Text("Is in same week")
                            })
                            .padding()
                            .buttonStyle(BorderlessButtonStyle())
                            
                        }
                        
                    }
                    
                }
            }
            
        }.onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                currentDay = Calendar.current.component(.weekday, from: Date())
            }
        })
                   
        
    }
    
}

#Preview {
    InsightsView()
        .modelContainer(previewContainer)
}
