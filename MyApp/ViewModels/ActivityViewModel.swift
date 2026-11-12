//
//  ActivityViewModel.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//
// مافهمته
import Foundation



struct ActivityViewModel {
    let calendar: Calendar
    
    init(calendar: Calendar = .current) { // اضبط الاسبوع يبدأ من الاحد
        var adjustedCalendar = calendar
        adjustedCalendar.firstWeekday = 1
        self.calendar = adjustedCalendar
    }
    
    
    func startOfWeek(for date: Date) -> Date? {  //تستقبل تاريخًا وترجع بداية أسبوعه
        let week = calendar.dateInterval(of: .weekOfYear, for: date)
        return week?.start
    }
    
    func weekDates(startingAt weekStart: Date) -> [Date] { // نرجع ايام الاسبوع السبعه
        (0...6).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: weekStart)
        }
    }
    
    func datesOfWeek(for date: Date) -> [Date] {// تجمع الاثنين
        guard let start = startOfWeek(for: date) else {
            return []
        }

        return weekDates(startingAt: start)
        
    }
    
    
    
    func daysOfWeek(   // اجلت فهمها
        for date: Date,
        statusesByDate: [Date: DayStatus]
    ) -> [DayItem] {
        datesOfWeek(for: date).map { date in
            let dayStart = calendar.startOfDay(for: date)
            let status = statusesByDate[dayStart] ?? .notLogged

            return DayItem(status: status, date: dayStart)
        }
    }
}

