//
//  inboardingviwmodel.swift
//  Learning
//
//  Created by reem on 02/06/1448 AH.

import Foundation
import Observation


@Observable class OnboardingViewModel{
    
    var  duration:LearningDuration? = nil
    var subject:String = ""
    var currentGoal:LearningGoal? = nil
    
    var canStart:Bool{  // في حال المستخدم اختار فتره وهدف
        let result = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard  result != "" && duration != nil  else {
            return false
        }
        
        return true }
        
        func  startLearning(){ // هينا عشان مشكله الفترة ممكن تكون فاضيه فلازم اتأكد اذا فاضيه ولالا
            guard canStart, let durationn = duration else {
            return
            }
            currentGoal=LearningGoal( subject:subject.trimmingCharacters(in: .whitespacesAndNewlines),duration:durationn )

        }
        
    func prepareNewGoal() {
        subject = ""
        duration = nil

    }
        
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

    func saveCurrentData(from activityStore: ActivityStore) {
        LearningPersistence().saveLearningData(
            currentGoal: currentGoal,
            entriesByDate: activityStore.entriesByDate
        )
    }
        
        
        
        
        
        
        
        
        
        
    }
