//
//  DailyTaskManager.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 31/12/2023.
//

import Foundation

class DailyTaskManager:ObservableObject {
    
    @Published var lastExecutionDate: Date?
    
    func tomorrowDate() -> Date {
            return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        }
    
//    init(){
//        scheduleBackgroundTask()
//    }
    
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
    
}
