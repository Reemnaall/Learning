//
//  LearningGoalForm.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//

import SwiftUI

struct LearningGoalForm: View {
    @Binding  var subject:String
    @Binding var duration: LearningDuration?
    
    var body: some View {
        
        Text("I want to learn")
            .foregroundStyle(.primary)
            .font(.callout)
            .padding(.bottom, 5)
        TextField("swift",text: $subject)
            .frame(minHeight: 48)
        Divider()
            .padding(.bottom, 30)
        Text("I want to learn it in a")
            .padding(.bottom, 13)
            .foregroundStyle(.primary)
            .font(.callout)
        
        /*   HStack(spacing: 12) {
         Button("week") {
         duration = .week
         }
         Button("month") {
         duration = .month
         }
         Button("year") {
         duration = .year
         }
         }
         .font(.body)
         .fontWeight(.medium)
         .foregroundStyle(.secondary)
         .buttonStyle(.glass)
         .tint(.orange)*/
        
        HStack(spacing: 12) {
            ForEach(LearningDuration.allCases, id: \.self) { option in
                if duration == option {
                    Button(option.title) { duration = option }
                        .buttonStyle(.glassProminent)
                } else {
                    Button(option.title) { duration = option }
                        .buttonStyle(.glass)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .font(.body)
        .fontWeight(.medium)
        //.tint(.orange)
        .keyboardShortcut(.defaultAction)
    
    }
        
        
    }
    

