//
//  RootView.swift
//  Learning
//
//  Created by reem on 03/06/1448 AH.
//

import Foundation
import SwiftUI


struct RootView: View {
    
    
    // يحافظ على نسخة نموذج الهدف خلال تحديثات الواجهة.
    @State private var vm = OnboardingViewModel()
    // يحافظ على سجل واحد مشترك بين النشاط والتقويم.
    @State private var activityStore = ActivityStore()  // إنشاء المخزن
    // يتحكم بفتح التقويم.
    @State private var showsCalendar = false     // فتح التقويم
    // يتحكم بعرض صفحة تعديل الهدف.
    @State private var showsGoalEditor = false
    
    var body: some View {
        NavigationStack {
            // يحدّث الوقت كل دقيقة لإعادة فحص انتهاء الهدف.
            TimelineView(.everyMinute) { context in
                if let goal = vm.currentGoal {
                    // يمرّر السجل المشترك إلى منطق النشاط.
                    let activity = ActivityViewModel(store: activityStore)
                    
                    // يطلب محتوى النتيجة باستخدام الوقت وفترة الهدف والسجل.
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
                    // يفتح نموذج تعديل الهدف عند تغيير حالة العرض.
                    .sheet(isPresented: $showsGoalEditor) {
                        NavigationStack {
                            Update_Learning_goal(vm: vm)
                        }
                    }
                } else {
                    Onboarding(vm: vm)
                }
            }
            // ينتقل إلى التقويم من داخل نفس مسار التنقّل.
            .navigationDestination(isPresented: $showsCalendar) {
                Activities(
                    viewModel: YearCalendarViewModel(store: activityStore),
                    year: Calendar(identifier: .gregorian).component(.year, from: Date())
                )
            }
            // يطلب استعادة البيانات عند ظهور الصفحة.
            .task {
                vm.restoreSavedData(from: activityStore)
            }
            // يحفظ البيانات عند استبدال الهدف الحالي.
            .onChange(of: vm.currentGoal?.id) {
                vm.saveCurrentData(from: activityStore)
            }
            // يحفظ البيانات بعد تغيير تسجيلات الأيام.
            .onChange(of: activityStore.entriesByDate) {
                vm.saveCurrentData(from: activityStore)
            }
        }
        
    }
    
    
    
}
