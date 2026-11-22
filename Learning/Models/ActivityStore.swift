//
//  ActivityStore.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//يجمع بيانات تسجيل النشاط والمخزن المشترك


import Foundation
import Observation
// تسجيل يوم يحتوي الحالة وهوية الهدف ووقت التسجيل.
struct DayEntry: Codable,Equatable{
    let status: DayStatus
    let goalID: UUID
    let loggedAt: Date// وقت التسجيل الفعلي عشان ٣٢
}

// نسخة بيانات مشتركة تتابع الواجهة تغيّر سجلها.
@Observable final class ActivityStore {// عشان نشارك نسخه مع الكالندر والاكتفيتي
   // بداية اليوم هي المفتاح، والتسجيل هو القيمة.
   var entriesByDate: [Date: DayEntry] = [:]
}
