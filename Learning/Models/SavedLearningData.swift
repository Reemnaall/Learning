//
//  SavedLearningData.swift
//  Learning
//
//  Created by reem on 05/06/1448 AH.
//

import Foundation

// حزمة تجمع الهدف وسجل الأيام للحفظ معًا.
struct SavedLearningData: Codable {
    let currentGoal: LearningGoal?
    let entriesByDate: [Date: DayEntry]
}
