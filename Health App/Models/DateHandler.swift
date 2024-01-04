//
//  DateHandler.swift
//  Health App
//
//  Created by Tudor Hirtopanu on 04/01/2024.
//

import Foundation

struct DateComponents {
    var weekday: Int
    var day: Int
    var month: Int
    var year: Int
}

class DateHandler: ObservableObject {
    
    func getDateComponents(from date: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
        
        return DateComponents(weekday: components.weekday ?? 1,
                              day: components.day ?? 1,
                              month: components.month ?? 1,
                              year: components.year ?? 2000)
    }
    
    func calculateFutureDate(from date: Date, daysForward: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: daysForward, to: date)
    }
    
    func isDateInCurrentWeek(currentDate:Date, creationDate:Date) -> Bool {
        let calendar = Calendar.current
        
        //calendar.firstWeekday = 2
        
        
        let currentWeek = calendar.component(.weekOfYear, from: creationDate)
        let targetWeek = calendar.component(.weekOfYear, from: currentDate)
        
        return currentWeek == targetWeek
    }
    
    func returnDayName(day:Int) -> String {
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
    
}
