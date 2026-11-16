//
//  Update Learning goal.swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

struct Update_Learning_goal: View {
    @Bindable var vm: OnboardingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showsUpdateAlert = false
    var body: some View {
        
        VStack(alignment: .leading){
            LearningGoalForm(subject: $vm.subject, duration: $vm.duration )
        }
                .padding(EdgeInsets(top: 36, leading: 17, bottom: 0, trailing: 17))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .navigationTitle(" Learning Goal")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showsUpdateAlert = true
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                      //.tint(.orange)
                        .keyboardShortcut(.defaultAction)
                        .disabled(!vm.canStart)
                    }
                    
                }
                .alert("Update goal", isPresented: $showsUpdateAlert) {
                    Button("Dismiss", role: .cancel) {}
                   // Button("Update") {
                        Button("Update") {
                            vm.startLearning()//تتحقق من الاسم والمدة، ثم تنشئ الهدف بهوية وبداية جديدتين.
                            dismiss()
                        }
                        .keyboardShortcut(.defaultAction)
                   
                } message: {
                    Text("If you update now, your streak will start over.")
                }
            }
    
}
