//
//  Current day .swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

struct Current_day_: View {
 
    let goal: LearningGoal
    let viewModel: ActivityViewModel
    var resultContent: GoalResultContent? = nil
    var onOpenCalendar: () -> Void = {}
    var onEditGoal: () -> Void = {}
    
    var body: some View {
        let today = Date()
        let streakCount = viewModel.streak(for: goal, on: today)
        let decision = viewModel.actions(for: goal, on: today) // فيه قرار الزرّين والعدد المستخدم والحد
        let learnTint = viewModel.learnButtonTint(canLearn: decision.canLearn)
        let freezeTint = viewModel.freezeButtonTint(canFreeze: decision.canFreeze)
        
        VStack(alignment: .leading ,spacing:0) {
            headar(
                today: today,
                onOpenCalendar: onOpenCalendar,
                onEditGoal: onEditGoal
            )
            .padding(.horizontal, 16)
            .padding(.bottom ,18)
            
            WeekRowView(
                days:viewModel.daysOfWeek(for: today, goal: goal),
                calendar: viewModel.calendar,
                referenceDate: today
            ) .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom ,12)
            VStack(spacing: 48) {
                HStack(spacing: 12){
                    Cards(icon:"flame.fill",
                      
                          daysText: viewModel.daysText(for: streakCount),
                          description:"learned",
                          iconcolor:.orange)
                    Cards(icon:"snowflake",
                      
                          daysText: viewModel.daysText(for: decision.used),
                          description:"freezed",
                          iconcolor:.cyan)
                }
            .padding(.horizontal, 16)
                if let content = resultContent {
                    GoalResultView(
                        iconName: content.iconName,
                        title: content.title,
                        subtitle: content.subtitle,
                        onSetGoal: onEditGoal
                    )
                    .frame(maxWidth: .infinity)
                } else {
                    ActiveGoalActionsView(
                        onLogLearned: {
                            viewModel.recordStatus(.learned, for: Date(), goal: goal)
                        },
                        onFreeze: {
                            viewModel.recordStatus(.frozen, for: Date(), goal: goal)
                        },
                        freezesUsed: decision.used,
                        freezeLimit: decision.limit,
                        canLearn: decision.canLearn,
                        canFreeze: decision.canFreeze,learnTint: learnTint,freezeTint: freezeTint,learnTitle: viewModel.learnButtonTitle(canLearn: decision.canLearn),
                        freezeTitle: viewModel.freezeButtonTitle(canFreeze: decision.canFreeze)
                    )
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview("Activity") {
    Current_day_(
        goal: LearningGoal(subject: "SwiftUI", duration: .week),
        viewModel: ActivityViewModel()
    )
}

