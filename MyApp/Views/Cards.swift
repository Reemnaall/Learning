//
//  Cards.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.
//

import SwiftUI

struct Cards: View {
    let icon: String
    let days: Int
    let description:String
    let iconcolor: Color

    var body: some View {
        VStack {
                    Image(systemName: icon)
                        .foregroundStyle(iconcolor)

                    Text("\(days) days")
                    Text(description)
                }
        .frame(maxWidth:.infinity)
        .padding(20)
        .glassEffect(
        .regular.tint(.black.opacity(0.5)),
            in: RoundedRectangle(cornerRadius: 24))
        
    }
}

#Preview {
    HStack(spacing: 12) {
        Cards(icon:"flame.fill",
              days:3,
              description:"learner",
              iconcolor:.orange)
        Cards(icon:"snowflake",
              days:3,
              description:"freeze",
              iconcolor:.blue)}
}
