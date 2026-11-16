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
    var body: some View {
        
        VStack(spacing: 48) {
            Button {
                onLogLearned()
            } label: {
                Text("Log as Learned")
                    .font(.body)
                    .fontWeight(.medium)
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
                    Text("Freeze for a day")
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(width: 272, height: 46)
                       // .glassEffect(.regular.tint(.cyan), in: Capsule())
                        .glassEffect(.regular.tint(freezeTint), in: Capsule())
                }
                .buttonStyle(.plain)
                .disabled(!canFreeze)
                
                Text("\(freezesUsed) out of \(freezeLimit) Freezes used")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

