//
//  LearningGoal.swift
//  Learning
//
//  Created by reem on 02/06/1448 AH.
//

import Foundation


// بيانات الهدف التي يمكن حفظها واستعادتها.
struct LearningGoal: Codable {  // هدف محفوظ
    let id: UUID
    let startedAt: Date
    var subject: String
    var duration: LearningDuration

    // يعطي الهدف الجديد هوية ووقت بداية جديدين.
    init(subject: String, duration: LearningDuration) { // هدف جديد
        self.id = UUID()
        self.startedAt = Date()
        self.subject = subject
        self.duration = duration
    }
}
