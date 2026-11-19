//
//  ActivityViewModel.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//
// مافهمته
import Foundation
import SwiftUI

/*struct DayEntry: Codable,Equatable{
    let status: DayStatus
    let goalID: UUID
    let loggedAt: Date// وقت التسجيل الفعلي عشان ٣٢
}
*/
@Observable final class ActivityViewModel {
    let calendar: Calendar
    private let store: ActivityStore
    
    
    private var statusesByDate: [Date: DayStatus] = [:]// يسجل حالات اليوم يبد فاضي
    
    init(calendar: Calendar = .current, store: ActivityStore = ActivityStore()) {
        self.store = store// اضبط الاسبوع يبدأ من الاحد
        var adjustedCalendar = calendar
        adjustedCalendar.firstWeekday = 1
        self.calendar = adjustedCalendar
    }
    
    

    func datesOfWeek(for date: Date) -> [Date] {
        guard let week = calendar.dateInterval(of: .weekOfYear, for: date) else {
            return []
        }

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: week.start)
        }
    
    }
   
    func dayItem(for date: Date) -> DayItem {  // تقرا
        let dayStart = calendar.startOfDay(for: date)
        let status = store.entriesByDate[dayStart]?.status ?? .notLogged
        return DayItem(status: status, date: dayStart)
    }

    /*func daysOfWeek(for date: Date) -> [DayItem] {
        datesOfWeek(for: date).map { day in
            dayItem(for: day)
        }
    }*/
    
    
    func daysOfWeek(for date: Date, goal: LearningGoal? = nil) -> [DayItem] {
        datesOfWeek(for: date).map { date in
            let day = dayItem(for: date)

            if let goal = goal {
                let entry = store.entriesByDate[day.date]

                if entry?.goalID != goal.id {
                    return DayItem(status: .notLogged, date: day.date)
                }
            }

            return day
        }
    }
    
    func recordStatus(_ status: DayStatus, for date: Date, goal: LearningGoal) {  // يجيب قرار الزرين اذا فيه مجال تضغط تعلم بيحفظ الحاله واذا لا بطلعها وهكذا مع الفريز
        let decision = actions(for: goal, on: date)

        if status == .learned && !decision.canLearn {
            return
        }

        if status == .frozen && !decision.canFreeze {
            return
        }

        if status == .notLogged {
            return
        }

        let dayStart = calendar.startOfDay(for: date)
        var loggedAt = date

        if let oldEntry = store.entriesByDate[dayStart] {
            if oldEntry.goalID == goal.id {
                loggedAt = oldEntry.loggedAt
            }
        }

        let entry = DayEntry(status: status, goalID: goal.id, loggedAt: loggedAt)
        store.entriesByDate[dayStart] = entry    }
    
    
    func freezeLimit(for duration: LearningDuration) -> Int {  // حد التجميد استخدمنا سويتش عشان نغطي كل الحالات
        switch duration {
        case .week:
            return 2
        case .month:
            return 8
        case .year:
            return 96
        }
    }
    
 func goalPeriod(for goal: LearningGoal) -> Range<Date>? {  // تحسب لنا مدة الهدف ومتى ينتهي
        let start = calendar.startOfDay(for: goal.startedAt)
        let end: Date?

        switch goal.duration {
        case .week:
            end = calendar.date(byAdding: .day, value: 7, to: start)
        case .month:
            end = calendar.date(byAdding: .month, value: 1, to: start)
        case .year:
            end = calendar.date(byAdding: .year, value: 1, to: start)
        }

        guard let end = end else {
            return nil
        }

        return start..<end
    }
    
    func freezesUsed(for goal: LearningGoal) -> Int { // عدد استخدمات ايام التجميد
        guard let period = goalPeriod(for: goal) else {
            return 0
        }

        var count = 0

        for (day, entry) in store.entriesByDate {
            if entry.status == .frozen &&
               entry.goalID == goal.id &&
               period.contains(day) {
                count += 1
            }
        }

        return count
    }
    
    func actions(for goal: LearningGoal, on date: Date)    // لوجيك ازرار التجميد والتعلم والحد المسموح للتجميد
        -> (canLearn: Bool, canFreeze: Bool, used: Int, limit: Int) {

        let used = freezesUsed(for: goal)
        let limit = freezeLimit(for: goal.duration)
        let day = calendar.startOfDay(for: date)

        guard let period = goalPeriod(for: goal) else {
            return (canLearn: false, canFreeze: false, used: used, limit: limit)
        }

        guard period.contains(day) else {
            return (canLearn: false, canFreeze: false, used: used, limit: limit)
        }

        let hasFreezesLeft = used < limit

        if let entry = store.entriesByDate[day], entry.goalID == goal.id {
            if entry.status == .learned {
                return (canLearn: false, canFreeze: hasFreezesLeft, used: used, limit: limit)
            }

            if entry.status == .frozen {
                return (canLearn: true, canFreeze: false, used: used, limit: limit)
            }
        }

        return (canLearn: true, canFreeze: hasFreezesLeft, used: used, limit: limit)
    }
    
    func learnButtonTint(canLearn: Bool) -> Color? {
        if canLearn {
            return .orange
        }

        return nil
    }
    func freezeButtonTint(canFreeze: Bool) -> Color? {
        if canFreeze {
            return .cyan
        }

        return nil
    }
    
    func learnButtonTitle(canLearn: Bool) -> String {
        if canLearn {
            return "Log as Learned"
        }

        return "Logged as Learned"
    }

    func freezeButtonTitle(canFreeze: Bool) -> String {
        if canFreeze {
            return "Freeze for a day"
        }

        return "Freezed for a day"
    }
    
    func streak(for goal: LearningGoal, on date: Date) -> Int {
        let limitInSeconds: TimeInterval = 32 * 60 * 60

        let entries = store.entriesByDate.values.sorted { first, second in
            first.loggedAt < second.loggedAt
        }

        var count = 0
        var lastTime: Date? = nil

        for entry in entries {
            if entry.goalID == goal.id && entry.loggedAt <= date {
                if let previousTime = lastTime {
                    let seconds = entry.loggedAt.timeIntervalSince(previousTime)
                    if seconds > limitInSeconds {
                        count = 0
                    }
                }

                if entry.status == .learned {
                    count += 1
                }

                lastTime = entry.loggedAt
            }
        }

        if let previousTime = lastTime {
            let seconds = date.timeIntervalSince(previousTime)
            if seconds > limitInSeconds {
                return 0
            }
        }

        return count
    }
    
    func daysText(for days: Int) -> String {
        if days == 1 {
            return "\(days) day"
        }

        return "\(days) days"
    }
}

