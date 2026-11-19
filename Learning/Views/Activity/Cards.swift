//
//  Cards.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.
//

import SwiftUI

struct Cards: View {
    let icon: String
    let daysText: String
    let description:String
    let iconcolor: Color
    
    var body: some View {
        VStack(spacing: 6) {
                    Image(systemName: icon)
                   .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(iconcolor)
                    Text(daysText)
                .font(.system(size: 16, weight: .semibold))
                    Text(description)
                .font(.system(size: 12, weight: .regular))
                }
        .frame(maxWidth:.infinity)
        .padding(20)
        .glassEffect(
        .regular.tint(.black.opacity(0.15)),
            in: RoundedRectangle(cornerRadius: 24))
        
    }
}

