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
                onLogLearned()
            } label: {
                Text(learnTitle)
                    .font(.system(size: 17, weight: .bold))
                   // .font(.body)
                   // .fontWeight(.medium)
                    .frame(width: 272, height: 272)
                  //  .glassEffect(.regular.tint(.orange), in: Circle())
                    .glassEffect(.regular.tint(learnTint), in: Circle())
            }
            .buttonStyle(.plain)
            .disabled(!canLearn)
           
            VStack(spacing: 16) {
                Button {
                    onFreeze()
                } label: {
                    Text(freezeTitle)
                        .font(.system(size: 17, weight: .medium))
                     //   .font(.body.weight(.medium))
                    //    .font(.body)
                      //  .fontWeight(.medium)
                        .frame(width: 272, height: 46)
                       // .glassEffect(.regular.tint(.cyan), in: Capsule())
                        .glassEffect(.regular.tint(freezeTint), in: Capsule())
                }
                .buttonStyle(.plain)
                .disabled(!canFreeze)
                
                Text("\(freezesUsed) out of \(freezeLimit) Freezes used")
                    .foregroundStyle(.secondary)
                  //  .font(.caption)
                    .font(.system(size: 14, weight: .regular))
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

