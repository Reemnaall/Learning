//
//  RootView.swift
//  Learning
//
//  Created by reem on 03/06/1448 AH.
//

import Foundation
import SwiftUI


struct RootView: View {
    
    
    @State private var vm = OnboardingViewModel()
    @State private var activityStore = ActivityStore()
    @State private var showsCalendar = false
    @State private var showsGoalEditor = false
    
    var body: some View {
        TimelineView(.everyMinute) { context in
            if let goal = vm.currentGoal {
                let activity = ActivityViewModel(store: activityStore)
                
                let result = GoalResultViewModel().resultContent(
                    for: goal,
                    now: context.date,
                    period: activity.goalPeriod(for: goal),
                    store: activityStore,
                    calendar: activity.calendar
                )
                Current_day_(
                    goal: goal,
                    viewModel: activity,
                    resultContent: result,
                    onOpenCalendar: {
                        showsCalendar = true
                    },onEditGoal: {
                        vm.prepareNewGoal()
                        showsGoalEditor = true
                    }
                )
                .sheet(isPresented: $showsCalendar) {
                    NavigationStack {
                        Activities(
                            viewModel: YearCalendarViewModel(store: activityStore),
                            year: Calendar(identifier: .gregorian).component(.year, from: Date())
                        )
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    showsCalendar = false
                                } label: {
                                    Image(systemName: "chevron.left")
                                }
                                
                            }
                        }
                    }
                }
                .sheet(isPresented: $showsGoalEditor) {
                    NavigationStack {
                        Update_Learning_goal(vm: vm)
                    }
                }
            } else {
                Onboarding(vm: vm)
            }
            
            
            
        }
        .task {  // ربط load بفتح التطبيق
            do {
                if let savedData = try LearningPersistence().load() {
                    activityStore.entriesByDate = savedData.entriesByDate
                    vm.currentGoal = savedData.currentGoal
                }
            } catch {
                print("Could not load Learning data: \(error)")
            }
        }
        // استدعاء الحفظ عند تغير الهدف او السجل
        .onChange(of: vm.currentGoal?.id) {
            LearningPersistence().saveLearningData(
                currentGoal: vm.currentGoal,
                entriesByDate: activityStore.entriesByDate
            )
        }
        .onChange(of: activityStore.entriesByDate) {
            LearningPersistence().saveLearningData(
                currentGoal: vm.currentGoal,
                entriesByDate: activityStore.entriesByDate
            )
        }
    }
    
    }

