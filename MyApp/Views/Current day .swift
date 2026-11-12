//
//  Current day .swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

struct Current_day_: View {
    private let viewModel = ActivityViewModel()

    var body: some View {
        let today = Date()

        VStack(alignment: .leading ,spacing:0) {
            headar(today: today)
                .padding(.bottom ,18)
            
            WeekRowView(
                days: viewModel.daysOfWeek(for: today, statusesByDate: [:]),
                calendar: viewModel.calendar,
                referenceDate: today
            ) .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom ,12)
            VStack(spacing: 48) {
                HStack(spacing: 12){
                    Cards(icon:"flame.fill",
                          days:3,
                          description:"learner",
                          iconcolor:.orange)
                    Cards(icon:"snowflake",
                          days:3,
                          description:"freeze",
                          iconcolor:.blue)
                    
                }
                ActiveGoalActionsView()
            }
           }
           .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    Current_day_()
}
