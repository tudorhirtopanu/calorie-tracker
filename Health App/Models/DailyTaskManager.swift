//
//  DailyTaskManager.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 31/12/2023.
//

import Foundation

class DailyTaskManager:ObservableObject {
        
    
    
    private func scheduleBackgroundTask() {
        Task {
            await performDailyTaskIfNeeded()
        }
    }
    
     func performDailyTaskIfNeeded() async -> Bool {
        
        let currentDate = Calendar.current.startOfDay(for: Date())
        
        if isNewDay() {
            
            print("Delete Data")
            UserDefaults.standard.set(currentDate, forKey: "lastDeletionDateTest")
            return true
        } else {
            print("no need to delete data")
            return false
        }
        
    }
    
    
    
    func isNewDay() -> Bool {
        let storedDate = UserDefaults.standard.object(forKey: "lastDeletionDateTest") as? Date
        let currentDate = Calendar.current.startOfDay(for: Date())
        
        if let storedDate = storedDate {
            return !Calendar.current.isDate(storedDate, inSameDayAs: currentDate)
        } else {
            UserDefaults.standard.set(currentDate, forKey: "lastDeletionDateTest")
            return true
        }
        
    }
    
    func returnCurrentDay() -> Int {
        let currentDate = Date()

        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: currentDate)
        
        return dayOfWeek
    }
    
    func shouldDeleteWeeklyData() async -> Bool {
        
        if returnCurrentDay() == 1 {
            print("current day = \(returnCurrentDay())")
            return true
        } else {
            print("current day = \(returnCurrentDay())")
            return false
        }
        
    }
    
    func returnPreviousDay() -> Int {
        let currentDay = returnCurrentDay()
        
        if currentDay == 1 {
            return 7
        } else {
            return currentDay - 1
        }
    }
    
    func adjustedWeekday(weekday:Int) -> Int {
        
            var adjustedWeekday = weekday - 1
            if adjustedWeekday == 0 {
                adjustedWeekday = 7
            }
            return adjustedWeekday
        }
    
}
