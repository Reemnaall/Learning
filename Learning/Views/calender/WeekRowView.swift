//
//  WeekRowView.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//
//مافهمته
import SwiftUI

struct WeekRowView: View {
    let days: [DayItem]
    let calendar: Calendar
    let referenceDate: Date

    var body: some View {
        HStack(spacing: 10) {
            ForEach(days) { day in
                DayView(
                    day: day,
                    calendar: calendar,
                    referenceDate: referenceDate
                )
            }
        }
    }
}

