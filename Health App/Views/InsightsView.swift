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
    
    @State var showSettings:Bool = false
    
    @AppStorage("CalorieGoal") var calorieGoal:Int = 2300
    
    var body: some View {
        
        
        
        List {
            
            Section("Daily Progress"){
                VStack {
                    ProgressView(value: Float(calculateCalories(itemArray: todaysData)), total: Float(calorieGoal))
                    
                    HStack {
                        Text("Current: \(calculateCalories(itemArray: todaysData))")
                            .fontWeight(.medium)
                            .font(Font.system(size: 12))
                        Spacer()
                        Text("Goal: \(calorieGoal)")
                            .fontWeight(.medium)
                            .font(Font.system(size: 12))
                    }
                }
                .padding([.top])
            }

            Section("Weekly Calories") {
                VStack{
                    
                    ForEach(arrayOfDays, id: \.self) {day in
                        let dayData = returnDataItem(day: dtm.adjustedWeekday(weekday: day))
                        
                        let futureDate = dh.calculateFutureDate(from: Date(), daysForward: returnIndexOfDate(currentDayNum: currentDay, weekDayNum: day) - currentDay)!
                        
                        HStack {
                            HStack {
                                Text(dh.returnDayName(day:dtm.adjustedWeekday(weekday: day)))
                                    .frame(width:90, alignment: .leading)
                            }
                            
                            // Is Current Day
                            if dayData.day == dtm.adjustedWeekday(weekday: currentDay){
                                Text(String(calculateCalories(itemArray: todaysData)))
                                    .frame(width: 55, alignment: .trailing)
                            }else {
                                
                                if dayData.day != 7 {
                                    if dh.isDateInCurrentWeek(currentDate: futureDate, creationDate: dayData.creationDate){
                                        Text(String(dayData.totalCalories))
                                            .frame(width: 55, alignment: .trailing)
                                        
                                    }else {
                                        Text(String(00))
                                            .frame(width: 55, alignment: .trailing)
                                    }
                                } else {
                                    // MARK: Temp fix for showing 0 on sunday
                                    Text(String(0))
                                        .frame(width: 55, alignment: .trailing)
                                }
                                
                                
                            }
                            
                        }
                        .padding([.top, .bottom], 3)
                        
                    }
                    
                }
                
            }
            
            Button(action: {
                showSettings.toggle()
            }, label: {
                HStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            })
            
//            Button(action: {
//                deleteData()
//            }, label: {
//                Text("Delete Data")
//            })
            
        }

        .onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                currentDay = Calendar.current.component(.weekday, from: Date())
                
            }
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
                   
        
    }
    
}

#Preview {
    NavigationStack {
        InsightsView()
            .modelContainer(previewContainer)
    }
}
