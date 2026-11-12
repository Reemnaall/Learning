//
//  GoalResultView.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//

import SwiftUI

struct GoalResultView: View {
    
    let iconName:String
    let title:String
    let subtitle:String
    
    
    var body: some View {
        VStack(spacing:0){
            
            Image(systemName: iconName)
                .font(.system(size: 40, weight: .regular))
                .foregroundStyle(.orange)
                .padding(.bottom, 19)
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
            Text(subtitle)
                .font(.system(size: 14, weight:.medium))
                .foregroundStyle(.secondary)
            
            Button {
            } label: {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.primary)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .buttonBorderShape(.capsule)
            .tint(.orange)
            .padding(.top, 68)
            
            
        }
    }}
    
#Preview("Goal Completed") {
        GoalResultView(
            iconName: "hands.clap.fill",
            title: "Will done!",
            subtitle: "Ready for your next goal?"
        )
    }


#Preview("Goal Completed") {
        GoalResultView(
            iconName: "hands.clap.fill",
            title: "Will done!",
            subtitle: "Ready for your next goal?"
        )
    }
