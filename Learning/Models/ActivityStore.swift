//
//  ActivityStore.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//


import Foundation
import Observation
struct DayEntry: Codable,Equatable{
    let status: DayStatus
    let goalID: UUID
    let loggedAt: Date// وقت التسجيل الفعلي عشان ٣٢
}

@Observable final class ActivityStore {// عشان نشارك نسخه مع الكالندر والاكتفيتي
   var entriesByDate: [Date: DayEntry] = [:]
}
