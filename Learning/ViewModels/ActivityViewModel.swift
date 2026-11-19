//
//  ActivityViewModel.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//
// مافهمته
import Foundation
import SwiftUI


// يجهّز بيانات النشاط وتراقب الواجهة تغيّر البيانات التي تقرؤها.
@Observable final class ActivityViewModel {
    let calendar: Calendar
    private let store: ActivityStore
    
    
    private var statusesByDate: [Date: DayStatus] = [:] // قاموس قديم؛ الدوال الحالية تستخدم store.entriesByDate.
    
    init(calendar: Calendar = .current, store: ActivityStore = ActivityStore()) {
        self.store = store // يحتفظ بنفس نسخة السجل التي وصلت عند الإنشاء.
        var adjustedCalendar = calendar
        adjustedCalendar.firstWeekday = 1 // يجعل الأحد أول يوم في الأسبوع.
        self.calendar = adjustedCalendar
    }
    
    

    // يرجع تواريخ الأسبوع بدءًا من اليوم المحدد في إعداد التقويم.
    func datesOfWeek(for date: Date) -> [Date] {
        guard let week = calendar.dateInterval(of: .weekOfYear, for: date) else {
            return []
        }

        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: week.start)
        }
    
    }
   
    // يقرأ حالة اليوم ويجهّزها مع التاريخ للعرض.
    func dayItem(for date: Date) -> DayItem {  // تقرا
        // يوحّد مفتاح التاريخ على بداية اليوم حتى تكون له خانة واحدة.
        let dayStart = calendar.startOfDay(for: date)
        let status = store.entriesByDate[dayStart]?.status ?? .notLogged
        return DayItem(status: status, date: dayStart)
    }

  
    
    // يجهّز صف الأسبوع ويعرض تسجيلات الهدف المطلوب فقط.
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
    
    // يتحقق من السماح بالتسجيل قبل تحديث خانة اليوم.
    func recordStatus(_ status: DayStatus, for date: Date, goal: LearningGoal) {  // يجيب قرار الزرين اذا فيه مجال تضغط تعلم بيحفظ الحاله واذا لا بطلعها وهكذا مع الفريز
        // يستخدم نفس قرار الأزرار للتحقق قبل الحفظ.
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

        // يوحّد مفتاح التاريخ على بداية اليوم حتى تكون له خانة واحدة.
        let dayStart = calendar.startOfDay(for: date)
        // يبدأ بوقت الضغطة ويحافظ على وقت أول تسجيل عند التصحيح لنفس الهدف.
        var loggedAt = date

        if let oldEntry = store.entriesByDate[dayStart] {
            if oldEntry.goalID == goal.id {
                // التصحيح يغيّر الحالة مع الاحتفاظ بوقت التسجيل الأول.
                loggedAt = oldEntry.loggedAt
            }
        }

        let entry = DayEntry(status: status, goalID: goal.id, loggedAt: loggedAt)
        // يضيف التسجيل أو يستبدل قيمة نفس اليوم.
        store.entriesByDate[dayStart] = entry    }
    
    
    // يرجع عدد فرص التجميد حسب مدة الهدف.
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
    
 // يحسب فترة الهدف من بداية يوم إنشائه إلى وقت نهايته.
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

        // الفترة تشمل البداية وتتوقف قبل تاريخ النهاية.
        return start..<end
    }
    
    // يعد الأيام المجمّدة لهذا الهدف داخل فترته.
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
    
    // يجمع قرار الزرّين وعدد التجميدات وحدها في نتيجة واحدة.
    func actions(for goal: LearningGoal, on date: Date)    // لوجيك ازرار التجميد والتعلم والحد المسموح للتجميد
        -> (canLearn: Bool, canFreeze: Bool, used: Int, limit: Int) {

        let used = freezesUsed(for: goal)
        let limit = freezeLimit(for: goal.duration)
        let day = calendar.startOfDay(for: date)

        guard let period = goalPeriod(for: goal) else {
            return (canLearn: false, canFreeze: false, used: used, limit: limit)
        }

        // يمنع التسجيل إذا كان اليوم خارج فترة الهدف.
        guard period.contains(day) else {
            return (canLearn: false, canFreeze: false, used: used, limit: limit)
        }

        // يتأكد أن المستخدم لم يصل إلى حد التجميد.
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
    
    // يجهّز صبغة زر التعلّم حسب السماح بالضغط.
    func learnButtonTint(canLearn: Bool) -> Color? {
        if canLearn {
            return .orange
        }

        return nil
    }
    // يجهّز صبغة زر التجميد حسب السماح بالضغط.
    func freezeButtonTint(canFreeze: Bool) -> Color? {
        if canFreeze {
            return .cyan
        }

        return nil
    }
    
    // يختار نص زر التعلّم حسب حالته.
    func learnButtonTitle(canLearn: Bool) -> String {
        if canLearn {
            return "Log as Learned"
        }

        return "Logged as Learned"
    }

    // يختار نص زر التجميد حسب حالته.
    func freezeButtonTitle(canFreeze: Bool) -> String {
        if canFreeze {
            return "Freeze for a day"
        }

        return "Freezed for a day"
    }
    
    // يحسب سلسلة التعلّم اعتمادًا على وقت التسجيل وهوية الهدف.
    func streak(for goal: LearningGoal, on date: Date) -> Int {
        // يحوّل مهلة ٣٢ ساعة إلى ثوانٍ للمقارنة.
        let limitInSeconds: TimeInterval = 32 * 60 * 60

        // يرتّب التسجيلات من الأقدم إلى الأحدث.
        let entries = store.entriesByDate.values.sorted { first, second in
            first.loggedAt < second.loggedAt
        }

        var count = 0
        var lastTime: Date? = nil

        for entry in entries {
            if entry.goalID == goal.id && entry.loggedAt <= date {
                if let previousTime = lastTime {
                    let seconds = entry.loggedAt.timeIntervalSince(previousTime)
                    // تجاوز مهلة ٣٢ ساعة يقطع السلسلة.
                    if seconds > limitInSeconds {
                        count = 0
                    }
                }

                if entry.status == .learned {
                    count += 1
                }

                // التعلّم والتجميد كلاهما يحدّثان وقت آخر تسجيل.
                lastTime = entry.loggedAt
            }
        }

        if let previousTime = lastTime {
            let seconds = date.timeIntervalSince(previousTime)
            // تجاوز مهلة ٣٢ ساعة يقطع السلسلة.
            if seconds > limitInSeconds {
                return 0
            }
        }

        return count
    }
    
    // يستخدم المفرد للعدد واحد والجمع لباقي الأعداد.
    func daysText(for days: Int) -> String {
        if days == 1 {
            return "\(days) day"
        }

        return "\(days) days"
    }
}

