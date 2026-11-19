//
//  ActiveGoalActionsView.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//
import SwiftUI

struct ActiveGoalActionsView: View {
    
  
    let onLogLearned: () -> Void
    let onFreeze: () -> Void
    let freezesUsed: Int
    let freezeLimit: Int
    let canLearn: Bool
    let canFreeze: Bool
    let learnTint: Color?
    let freezeTint: Color?
    let learnTitle: String
    let freezeTitle: String
    var body: some View {
        
        VStack(spacing: 48) {
            Button {
                // يرسل طلب تسجيل التعلّم إلى الشاشة الأم.
                onLogLearned()
            } label: {
                Text(learnTitle)
                    // يضبط حجم الخط ووزنه لهذا العنصر.
                    .font(.system(size: 17, weight: .bold))
                   // .font(.body)
                   // .fontWeight(.medium)
                    .frame(width: 272, height: 272)
                  //  .glassEffect(.regular.tint(.orange), in: Circle())
                    // يطبّق تأثير Liquid Glass الأصلي على شكل العنصر.
                    .glassEffect(.regular.tint(learnTint), in: Circle())
            }
            .buttonStyle(.plain)
            // يعطّل زر التعلّم بناءً على القرار القادم من ViewModel.
            .disabled(!canLearn)
           
            VStack(spacing: 16) {
                Button {
                    // يرسل طلب التجميد إلى الشاشة الأم.
                    onFreeze()
                } label: {
                    Text(freezeTitle)
                        // يضبط حجم الخط ووزنه لهذا العنصر.
                        .font(.system(size: 17, weight: .medium))
                     //   .font(.body.weight(.medium))
                    //    .font(.body)
                      //  .fontWeight(.medium)
                        .frame(width: 272, height: 46)
                       // .glassEffect(.regular.tint(.cyan), in: Capsule())
                        // يطبّق تأثير Liquid Glass الأصلي على شكل العنصر.
                        .glassEffect(.regular.tint(freezeTint), in: Capsule())
                }
                .buttonStyle(.plain)
                // يعطّل زر التجميد بناءً على القرار القادم من ViewModel.
                .disabled(!canFreeze)
                
                Text("\(freezesUsed) out of \(freezeLimit) Freezes used")
                    .foregroundStyle(.secondary)
                  //  .font(.caption)
                    // يضبط حجم الخط ووزنه لهذا العنصر.
                    .font(.system(size: 14, weight: .regular))
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

