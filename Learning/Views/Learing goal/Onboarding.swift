//
//  Onboarding.swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.


import SwiftUI

struct Onboarding: View {
   // @State private var subject = ""
    
    @Bindable var vm:OnboardingViewModel
    
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
                
                LearningGoalForm(subject: $vm.subject, duration: $vm.duration )
              
               // LearningGoalForm( duration: $vm.duration ,subject: $vm.subject)
            }
              .padding(.horizontal, 17)
            Spacer()
            VStack(spacing:12) {
                Button("start learning") {
                    vm.startLearning()
                }
                .disabled(!vm.canStart)
                .font(.body)
                .fontWeight(.medium)
                .buttonStyle(.glassProminent)
                //.tint(.orange)
//                .keyboardShortcut(.defaultAction)
                .foregroundStyle(.accent)
                Text("You can edit your desire later")
                .foregroundStyle(.secondary)
                .font(.caption)
            }
            .padding(.bottom, 8)
              
            

        }
        
        
    
    }
}
