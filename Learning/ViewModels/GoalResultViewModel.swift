//
//  GoalResultViewModel.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//

import Foundation


struct GoalResultContent {
    let iconName: String
    let title: String
    let subtitle: String
}

final class GoalResultViewModel {
    
    func hasGoalEnded(now: Date, end: Date) -> Bool { // تحدد متي تعرض النتيجه
        return now >= end
    }
    
    
    func isGoalComplete(
        goal: LearningGoal,
        period: Range<Date>,
        store: ActivityStore,
        calendar: Calendar
    ) -> Bool {
        var day = period.lowerBound

        while day < period.upperBound {
            guard let entry = store.entriesByDate[day] else {
                return false
            }

            if entry.goalID != goal.id {
                return false
            }

            if entry.status == .notLogged {
                return false
            }

            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: day) else {
                return false
            }

            day = calendar.startOfDay(for: nextDay)
        }

        return true
    }
    
    
    func content(for completed: Bool) -> GoalResultContent {
        if completed {
            return GoalResultContent(
                iconName: "hands.clap.fill",
                title: "Will done!",
                subtitle: "Ready for your next goal?"
            )
        }

        return GoalResultContent(
            iconName: "xmark.seal",
            title: "You didn't reach your goal this time.",
            subtitle: "Want to set another goal?"
        )
    }
    func resultContent(   //إذا الهدف لسه مستمر، ترجع nil فتظل أزرار النشاط ظاهرة. وإذا انتهى، تفحص أيامه وترجع الأيقونة والنص المناسب لـ**«اكتمل الهدف»** أو «لم يتحقق الهدف».
        for goal: LearningGoal,
        now: Date,
        period: Range<Date>?,
        store: ActivityStore,
        calendar: Calendar
    ) -> GoalResultContent? {
        guard let period = period else {
            return nil
        }

        let ended = hasGoalEnded(now: now, end: period.upperBound)

        if ended == false {
            return nil
        }

        let completed = isGoalComplete(
            goal: goal,
            period: period,
            store: store,
            calendar: calendar
        )

        return content(for: completed)
    }
    
    
}
