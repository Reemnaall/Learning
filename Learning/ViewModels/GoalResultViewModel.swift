//
//  GoalResultViewModel.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//

import Foundation


// يحمل النصوص والأيقونة الجاهزة لعرض نتيجة الهدف.
struct GoalResultContent {
    let iconName: String
    let title: String
    let subtitle: String
}

final class GoalResultViewModel {
    
    // يتحقق من الوصول إلى وقت النهاية أو تجاوزه.
    func hasGoalEnded(now: Date, end: Date) -> Bool { // تحدد متي تعرض النتيجه
        return now >= end
    }
    
    
    // يتأكد أن كل يوم في الفترة مسجّل لهذا الهدف.
    func isGoalComplete(
        goal: LearningGoal,
        period: Range<Date>,
        store: ActivityStore,
        calendar: Calendar
    ) -> Bool {
        // يبدأ الفحص من أول يوم في الفترة.
        var day = period.lowerBound

        // يمر على أيام الهدف حتى ما قبل وقت النهاية.
        while day < period.upperBound {
            // غياب تسجيل أي يوم يعني أن الهدف غير مكتمل.
            guard let entry = store.entriesByDate[day] else {
                return false
            }

            // تسجيل هدف آخر لا يغطي هذا اليوم للهدف الحالي.
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
    
    
    // يختار محتوى النجاح أو عدم التحقق.
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
    // يرجع محتوى النتيجة بعد انتهاء المدة، وnil أثناء استمرارها.
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
