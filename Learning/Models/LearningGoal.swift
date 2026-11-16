//
//  LearningGoal.swift
//  Learning
//
//  Created by reem on 02/06/1448 AH.
//

import Foundation

/*struct LearningGoal{
    
    let id = UUID() // هويه للهدف تتحدث مع كل هدف جديد(الهدف يعرف هويته)
    let startedAt = Date()// اللحظه الحاليه وقت انشاء الهدف
    var subject:String
    var  duration:LearningDuration
  
    

    
}
*/
struct LearningGoal: Codable {  // هدف محفوظ
    let id: UUID
    let startedAt: Date
    var subject: String
    var duration: LearningDuration

    init(subject: String, duration: LearningDuration) { // هدف جديد
        self.id = UUID()
        self.startedAt = Date()
        self.subject = subject
        self.duration = duration
    }
}
