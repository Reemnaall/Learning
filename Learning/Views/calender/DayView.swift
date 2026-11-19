//
//  DayView.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.
//مافهمته

import SwiftUI

struct DayView: View {

    let day: DayItem
    let calendar: Calendar
    let referenceDate: Date
    
    // يستخرج الحرف المختصر لاسم يوم الأسبوع.
    private var weekday: String {
        let index = calendar.component(.weekday, from: day.date) - 1
        return calendar.veryShortWeekdaySymbols[index]
    }
    
    // يستخرج رقم اليوم داخل الشهر.
    private var dayNumber: Int {
        calendar.component(.day, from: day.date)
    }
    
    private var status: DayStatus {
        day.status
    }
    
    // يقارن التاريخين على مستوى اليوم.
    private var isToday: Bool {
        calendar.isDate(day.date, inSameDayAs: referenceDate)
    }
    
    // يبرز اليوم الحالي إذا لم يسجّل بعد.
    private var shouldHighlightToday: Bool {
        isToday && status == .notLogged
    }

    // يختار لون التعلّم أو التجميد أو الخانة الفارغة.
    var backgroundColor: Color {
        switch status {
        case .learned:
            return .orange
        case .frozen:
            return .cyan
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
                .foregroundStyle(shouldHighlightToday ? Color.white : (status == .notLogged ? Color.primary :backgroundColor))
                .frame(width: 44, height: 44)
                .background {
                        Circle()
                        .fill(shouldHighlightToday ?  Color.orange :  backgroundColor.opacity(0.15))

                    }
        }
    }
}

