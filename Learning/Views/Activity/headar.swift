//
//  headar.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.


import SwiftUI

struct headar: View {
    
    let today : Date
    var onOpenCalendar: () -> Void = {}
    var onEditGoal: () -> Void = {}
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("Activity")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button {
                        
                        onOpenCalendar()
                        
                    } label: {
                        Image(systemName: "calendar")
                            .font(.body)
                            .fontWeight(.medium)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular, in: Circle())
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        onEditGoal()
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .font(.body)
                            .fontWeight(.medium)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular, in: Circle())
                    }
                    .buttonStyle(.plain)
                    
                }
                
            }
            VStack(alignment:.leading) {
                Text(today,
                     format:.dateTime
                    .weekday(.wide)
                    .day()
                    .month(.wide))
            }
            .font(.body)
            .foregroundStyle(.secondary)
        }
    }
}
