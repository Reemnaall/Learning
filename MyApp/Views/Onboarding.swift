//
//  Onboarding.swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

struct Onboarding: View {
    @State private var subject = ""
    
    var body: some View {
       
        VStack(spacing:0) {
            Image(systemName: "flame.fill")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.orange)
                .padding(.bottom, 80 )
                .padding(.top, 57 )
            VStack(alignment: .leading ,spacing:0) {
                VStack(alignment: .leading) {
                    Text("Hello **Learner**")
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                    Text("This app will help you learn everyday!")
                    .foregroundStyle(.secondary)
                }
                .padding(.bottom, 37)
                /* Text("I want to learn")
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
                
                HStack(spacing: 12) {
                    Button("week") {
                    }
                    Button("month") {
                    }
                    Button("year") {
                    }
                }
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .buttonStyle(.glass)
                .tint(.orange)*/
                
              LearningGoalForm(subject:Binding.constant(""))
            }
              .padding(.horizontal, 17)
            Spacer()
            VStack(spacing:12) {
                Button("start learning") {
                    
                }
                .font(.body)
                .fontWeight(.medium)
                .buttonStyle(.glassProminent)
                .tint(.orange)
                Text("You can edit your desire later")
                .foregroundStyle(.secondary)
                .font(.caption)
            }
            .padding(.bottom, 8)
              
            

        }
        
        
    
    }
}

#Preview {
    Onboarding()
}
