//
//  Update Learning goal.swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

struct Update_Learning_goal: View {
    var body: some View {
        
        VStack(alignment: .leading){
            LearningGoalForm(subject:Binding.constant(""))}
        .padding(EdgeInsets(top: 36, leading: 17, bottom: 0, trailing: 17))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                   .navigationTitle(" Learning Goal")
                   .navigationBarTitleDisplayMode(.inline)
                   .toolbar {
                       ToolbarItem(placement: .topBarLeading) {
                           Button {
                           } label: {
                               Image(systemName: "chevron.backward")
                           }
                         
                       }

                       ToolbarItem(placement: .topBarTrailing) {
                           Button {
                           } label: {
                               Image(systemName: "checkmark")
                                   .foregroundStyle(.white)
                           }
                           .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.circle)
                            .tint(.orange)
                     
                       }
                   }
    }
}

#Preview {
    NavigationStack {
        Update_Learning_goal()
    }}
