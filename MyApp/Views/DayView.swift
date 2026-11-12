//
//  DayView.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.
//مافهمته

import SwiftUI

struct DayView: View {
    /*
     let weekday:String
     let  dayNumber:Int
     let  status:DayStatus
     let isToday: Bool
     */
    let day: DayItem
    let calendar: Calendar
    let referenceDate: Date
    
    private var weekday: String {
        let index = calendar.component(.weekday, from: day.date) - 1
        return calendar.veryShortWeekdaySymbols[index]
    }
    
    private var dayNumber: Int {
        calendar.component(.day, from: day.date)
    }
    
    private var status: DayStatus {
        day.status
    }
    
    private var isToday: Bool {
        calendar.isDate(day.date, inSameDayAs: referenceDate)
    }

    var backgroundColor: Color {
        switch status {
        case .learned:
            return .orange
        case .frozen:
            return .blue
        case .notLogged:
            return .clear
        }
    }
    var body: some View {
        VStack (spacing:4){
            Text(weekday)
            .font(.footnote)
            .fontWeight(.semibold)
            Text("\(dayNumber)")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(isToday ? Color.white : (status == .notLogged ? Color.primary :backgroundColor))
                .frame(width: 44, height: 44)
                .background {
                        Circle()
                        .fill(isToday ?  Color.orange :  backgroundColor.opacity(0.15))

                    }
        }
    }
}

#Preview {
    let now = Date()
    DayView(
        day: DayItem(status: .notLogged, date: now),
        calendar: .current,
        referenceDate: now
    )
}
