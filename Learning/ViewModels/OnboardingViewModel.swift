//
//  inboardingviwmodel.swift
//  Learning
//
//  Created by reem on 02/06/1448 AH.

import Foundation
import Observation


// يدير مسودة النموذج والهدف الحالي واستعادة بياناته.
@Observable class OnboardingViewModel{
    
    var  duration:LearningDuration? = nil
    var subject:String = ""
    var currentGoal:LearningGoal? = nil
    
    // يسمح بالحفظ بعد كتابة اسم واختيار مدة.
    var canStart:Bool{  // في حال المستخدم اختار فتره وهدف
        // يزيل الفراغات والأسطر من أطراف الاسم قبل التحقق.
        let result = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard  result != "" && duration != nil  else {
            return false
        }
        
        return true }
        
        // ينشئ هدفًا جديدًا بعد التحقق من النموذج.
        func  startLearning(){ // هينا عشان مشكله الفترة ممكن تكون فاضيه فلازم اتأكد اذا فاضيه ولالا
            guard canStart, let durationn = duration else {
            return
            }
            currentGoal=LearningGoal( subject:subject.trimmingCharacters(in: .whitespacesAndNewlines),duration:durationn )

        }
        
    // يفضّي مسودة النموذج مع إبقاء الهدف الحالي حتى تأكيد الحفظ.
    func prepareNewGoal() {
        subject = ""
        duration = nil

    }
        
    // يعيد الهدف والسجل المحفوظين عند فتح التطبيق.
    func restoreSavedData(from activityStore: ActivityStore) {
        do {
            if let savedData = try LearningPersistence().load() {
                activityStore.entriesByDate = savedData.entriesByDate
                currentGoal = savedData.currentGoal
            }
        } catch {
            print("Could not load Learning data: \(error)")
        }
    }

    // يمرّر القيم الحالية إلى مسؤول الحفظ.
    func saveCurrentData(from activityStore: ActivityStore) {
        LearningPersistence().saveLearningData(
            currentGoal: currentGoal,
            entriesByDate: activityStore.entriesByDate
        )
    }
        
        
        
        
        
        
        
        
        
        
    }
