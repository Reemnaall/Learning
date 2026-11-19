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
    @State private var activityStore = ActivityStore()  // إنشاء المخزن
    @State private var showsCalendar = false     // فتح التقويم
    @State private var showsGoalEditor = false
    
    var body: some View {
        NavigationStack {
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
                    .sheet(isPresented: $showsGoalEditor) {
                        NavigationStack {
                            Update_Learning_goal(vm: vm)
                        }
                    }
                } else {
                    Onboarding(vm: vm)
                }
            }
            .navigationDestination(isPresented: $showsCalendar) {
                Activities(
                    viewModel: YearCalendarViewModel(store: activityStore),
                    year: Calendar(identifier: .gregorian).component(.year, from: Date())
                )
            }
            .task {
                vm.restoreSavedData(from: activityStore)
            }
            .onChange(of: vm.currentGoal?.id) {
                vm.saveCurrentData(from: activityStore)
            }
            .onChange(of: activityStore.entriesByDate) {
                vm.saveCurrentData(from: activityStore)
            }
        }
        
    }
    
    
    
}
