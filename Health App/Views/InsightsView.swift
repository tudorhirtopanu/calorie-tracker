//
//  InsightsView.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 03/01/2024.
//

import SwiftUI
import SwiftData



struct InsightsView: View {

    let currentDate = Date()
    let daysForward = 30
    
    @Query private var dailyData:[DailyNutrientData]
    @Query private var todaysData:[FoodDataItem]
    
    @Environment(\.modelContext) private var context
    
    private func returnDataItem(day:Int)->DailyNutrientData {
        return dailyData.first(where: { $0.day == day}) ?? DailyNutrientData(day: day, totalCalories: 0, totalProtein: 0, creationDate: Date())
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
    
    @State var arrayOfDays:[Int] = [2, 3, 4, 5, 6, 7, 1]
    @State var currentDay = Calendar.current.component(.weekday, from: Date())
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var dtm = DailyTaskManager()
    @StateObject var dh = DateHandler()
    
    @Query(filter: #Predicate<DailyNutrientData>{food in
        food.day == 1
    }, sort: \.creationDate, order: .forward) private var daysData:[DailyNutrientData]
    
    func getDayOfMonthForDate(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekday], from: date)
        
        guard let firstDayOfMonth = calendar.date(from: components) else {
            return 0
        }
        
        let daysDifference = calendar.dateComponents([.day], from: firstDayOfMonth, to: date).day ?? 0
        return daysDifference + 1
    }
    
    func returnIndexOfDate(currentDayNum:Int, weekDayNum:Int) -> Int {
        
        // get index of the current day
        let indexOfDay = arrayOfDays.firstIndex(of: currentDayNum)
        
        // get index of the weekday in the list
        let indexOfWeekDay = arrayOfDays.firstIndex(of: weekDayNum)
        
        let difference = indexOfWeekDay! - indexOfDay!
        
        return currentDayNum + difference
        
    }
    
    var body: some View {
        
        
        
        List {
//            Button(action: {
//                if let futureDate = dh.calculateFutureDate(from: currentDate, daysForward: daysForward) {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "dd MMM yyyy"
//                    let formattedDate = dateFormatter.string(from: futureDate)
//
//                    print("\(daysForward) days forward from today is \(formattedDate)")
//                } else {
//                    print("Failed to calculate future date.")
//                }
//            }, label: {
//                Text("get new date")
//            })
            
            
            Button(action: {
                deleteData()
            }, label: {
                Text("Delete Data")
            })
            
//            VStack{
//                let date = dh.getDateComponents(from: Date())
//                Text(String(dh.returnDayName(day: dtm.adjustedWeekday(weekday: date.weekday))))
//                    .padding(.trailing,5)
//                HStack{
//                    Text(String(date.day))
//                        .padding(.trailing,5)
//                    Text(String(date.month))
//                        .padding(.trailing,5)
//                    Text(String(date.year))
//                        .padding(.trailing,5)
//                }
//            }
            
            
            
            Section {
                VStack(alignment: .leading){
                    
                    ForEach(arrayOfDays, id: \.self) {day in
                        let dayData = returnDataItem(day: dtm.adjustedWeekday(weekday: day))
                        
                        let futureDate = dh.calculateFutureDate(from: Date(), daysForward: returnIndexOfDate(currentDayNum: currentDay, weekDayNum: day) - currentDay)!
                        
                        HStack {
                            HStack {
                                Text(dh.returnDayName(day:dtm.adjustedWeekday(weekday: day)))
                                    .frame(width:100)
                            }
                            
                            // Is Current Day
                            if dayData.day == dtm.adjustedWeekday(weekday: currentDay){
                                Text(String(calculateCalories(itemArray: todaysData)))
                            }else {
                                
                                if dayData.day != 7 {
                                    if dh.isDateInCurrentWeek(currentDate: futureDate, creationDate: dayData.creationDate){
                                        Text(String(dayData.totalCalories))
                                        
                                    }else {
                                        Text(String(00))
                                    }
                                } else {
                                    // MARK: Temp fix for showing 0 on sunday
                                    Text(String(0))
                                }
                                
                                
                            }
                            
                            
//                            Button(action: {
//                                print(dh.isDateInCurrentWeek(currentDate: futureDate, creationDate: dayData.creationDate))
//                                print("Created on \(dayData.creationDate)")
//                                print("Date: \(futureDate)")
//                                
//                            }, label: {
//                                Text("same week?")
//                            })
//                            .padding(5)
//                            .buttonStyle(BorderlessButtonStyle())
                            
//                            Text(String(returnIndexOfDate(currentDayNum: currentDay, weekDayNum: day) - currentDay))
                            VStack{
                                
                                
//                                Text(String(futureDateComponents.day))
                                
                                
//                                Text(String(dh.returnDayName(day: dtm.adjustedWeekday(weekday: date.weekday))))
//                                    .padding(.trailing,5)
//                                HStack{
//                                    Text(String(date.day))
//                                        .padding(.trailing,5)
//                                        .font(Font.system(size: 12))
//                                    Text(String(date.month))
//                                        .padding(.trailing,5)
//                                        .font(Font.system(size: 12))
//                                    Text(String(date.year))
//                                        .padding(.trailing,5)
//                                        .font(Font.system(size: 12))
//                                }
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
        }.onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                currentDay = Calendar.current.component(.weekday, from: Date())
                
//                if currentDay != 1 {
//                    if daysData.count > 0 {
//                        if daysData.first!.totalCalories != 0 {
//                            for day in daysData {
//                                day.totalCalories = 0
//                                day.totalProtein = 0
//                            }
//                        }
//                    }
//                }
                
            }
        })
                   
        
    }
    
}

#Preview {
    InsightsView()
        .modelContainer(previewContainer)
}
