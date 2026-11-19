//
//  YearCalendarViewModel.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
import Foundation

// يجهّز شهور السنة وحالات الأيام من السجل المشترك.
final class YearCalendarViewModel {
    private let store: ActivityStore
    private let calendar = Calendar(identifier: .gregorian)

    init(store: ActivityStore) {
        self.store = store
    }

    // يجمع بيانات الشهور الاثني عشر بالترتيب.
    func months(for year: Int) -> [CalendarMonth] {
        var months: [CalendarMonth] = []

        for month in 1...12 {
            if let data = monthData(year: year, month: month) {
                months.append(data)
            }
        }

        return months
    }

    // يجهّز عنوان الشهر وخانات بدايته وأيامه.
    private func monthData(year: Int, month: Int) -> CalendarMonth? {
        // يحدد السنة والشهر واليوم الأول لبناء تاريخ الشهر.
        let date = DateComponents(year: year, month: month, day: 1)

        guard let firstDay = calendar.date(from: date) else {
            return nil
        }

        // يطلب من التقويم أرقام أيام الشهر بما فيها فبراير في السنة الكبيسة.
        guard let dayNumbers = calendar.range(of: .day, in: .month, for: firstDay) else {
            return nil
        }

        // يحسب الخانات التي تسبق يوم ١ عندما تبدأ الأعمدة بالأحد.
        let emptyCells = calendar.component(.weekday, from: firstDay) - 1
        var days: [CalendarDay] = []

        for number in dayNumbers {
            // يضيف صفرًا ليوم ١ ويزيد يومًا لكل رقم تالٍ.
            if let date = calendar.date(byAdding: .day, value: number - 1, to: firstDay) {
                // يوحّد مفتاح التاريخ على بداية اليوم حتى تكون له خانة واحدة.
                let dayStart = calendar.startOfDay(for: date)
                let status = store.entriesByDate[dayStart]?.status ?? .notLogged
                days.append(CalendarDay(number: number, status: status))
            }
        }

        return CalendarMonth(firstDay: firstDay, emptyCells: emptyCells, days: days)
    }
}
