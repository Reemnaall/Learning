//
//  YearCalendarViewModel.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
import Foundation

final class YearCalendarViewModel {
    private let store: ActivityStore
    private let calendar = Calendar(identifier: .gregorian)

    init(store: ActivityStore) {
        self.store = store
    }

    func months(for year: Int) -> [CalendarMonth] {
        var months: [CalendarMonth] = []

        for month in 1...12 {
            if let data = monthData(year: year, month: month) {
                months.append(data)
            }
        }

        return months
    }

    private func monthData(year: Int, month: Int) -> CalendarMonth? {
        let date = DateComponents(year: year, month: month, day: 1)

        guard let firstDay = calendar.date(from: date) else {
            return nil
        }

        guard let dayNumbers = calendar.range(of: .day, in: .month, for: firstDay) else {
            return nil
        }

        let emptyCells = calendar.component(.weekday, from: firstDay) - 1
        var days: [CalendarDay] = []

        for number in dayNumbers {
            if let date = calendar.date(byAdding: .day, value: number - 1, to: firstDay) {
                let dayStart = calendar.startOfDay(for: date)
                let status = store.entriesByDate[dayStart]?.status ?? .notLogged
                days.append(CalendarDay(number: number, status: status))
            }
        }

        return CalendarMonth(firstDay: firstDay, emptyCells: emptyCells, days: days)
    }
}
