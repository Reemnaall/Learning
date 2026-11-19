//
//  CalendarMonth.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//
//
//


import Foundation

// بيانات شهر واحد جاهزة لشبكة التقويم.
struct CalendarMonth {
    let firstDay: Date
    let emptyCells: Int
    let days: [CalendarDay]
}

// رقم اليوم وحالته داخل الشهر.
struct CalendarDay {
    let number: Int
    let status: DayStatus
}
