//
//  SavedLearningData.swift
//  Learning
//
//  Created by reem on 05/06/1448 AH.
//

import Foundation

struct SavedLearningData: Codable {
    let currentGoal: LearningGoal?
    let entriesByDate: [Date: DayEntry]
}
