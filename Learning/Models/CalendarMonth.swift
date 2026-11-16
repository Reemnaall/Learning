//
//  CalendarMonth.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//
//
//


import Foundation

struct CalendarMonth {
    let firstDay: Date
    let emptyCells: Int
    let days: [CalendarDay]
}

struct CalendarDay {
    let number: Int
    let status: DayStatus
}
