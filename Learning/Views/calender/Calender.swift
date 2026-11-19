//
//  Activities.swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

import SwiftUI

struct Activities: View {
    let viewModel: YearCalendarViewModel
    let year: Int

    private let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    // يوزّع الشبكة على سبعة أعمدة مرنة.
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // يرسم كل شهر من القائمة التي جهّزها ViewModel.
                ForEach(viewModel.months(for: year), id: \.firstDay) { month in
                    monthView(month)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
    }

    // يبني عنوان الشهر وشبكة أيامه.
    private func monthView(_ month: CalendarMonth) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(month.firstDay, format: .dateTime.month(.wide).year())
                //.font(.subheadline.weight(.semibold))
                // يضبط حجم الخط ووزنه لهذا العنصر.
                .font(.system(size: 17, weight: .semibold))
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        // يضبط حجم الخط ووزنه لهذا العنصر.
                        .font(.system(size: 13, weight: .bold))
                    //  .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                // يستخدم هويات سالبة للخانات الفارغة حتى لا تتكرر مع أرقام الأيام.
                ForEach((-month.emptyCells)..<0, id: \.self) { _ in
                    Color.clear.frame(height: 32)
                }

                ForEach(month.days, id: \.number) { day in
                    dayCell(day)
                }
            }

            Divider()
        }
    }

    // يرسم رقم اليوم مع لون حالته وخلفيته.
    private func dayCell(_ day: CalendarDay) -> some View {
        Text("\(day.number)")
            // يضبط حجم الخط ووزنه لهذا العنصر.
            .font(.system(size: 20, weight: .regular))//توي ضفته اتاكد 
            .foregroundStyle(dayColor(day.status))
            .frame(width: 32, height: 32)
            .background(dayBackground(day.status), in: Circle())
    }

    // يحدد لون رقم اليوم حسب الحالة.
    private func dayColor(_ status: DayStatus) -> Color {
        switch status {
        case .learned: return .orange
        case .frozen: return .cyan
        case .notLogged: return .primary
        }
    }

    // يحدد صبغة دائرة اليوم حسب الحالة.
    private func dayBackground(_ status: DayStatus) -> Color {
        switch status {
        case .learned: return .orange.opacity(0.15)
        case .frozen: return .cyan.opacity(0.15)
        case .notLogged: return .clear
        }
    }
}

// بيانات تجريبية لمعاينة الشاشة داخل Xcode.
#Preview {
    NavigationStack {
        Activities(
            viewModel: YearCalendarViewModel(store: ActivityStore()),
            year: 2026
        )
    }
    .preferredColorScheme(.dark)
}
