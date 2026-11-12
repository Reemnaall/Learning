//
//  ActiveGoalActionsView.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//
import SwiftUI

struct ActiveGoalActionsView: View {
    var body: some View {
        VStack(spacing: 48) {
            Button {
            } label: {
                Text("Log as Learned")
                    .font(.body)
                    .fontWeight(.medium)
                    .frame(width: 272, height: 272)
                    .glassEffect(.regular.tint(.orange), in: Circle())
            }
            .buttonStyle(.plain)

            VStack(spacing: 16) {
                Button {
                } label: {
                    Text("Freeze for a day")
                        .font(.body)
                        .fontWeight(.medium)
                        .frame(width: 272, height: 46)
                        .glassEffect(.regular.tint(.cyan), in: Capsule())
                }
                .buttonStyle(.plain)

                Text("0 out of 2 Freezes used")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    ActiveGoalActionsView()
}
