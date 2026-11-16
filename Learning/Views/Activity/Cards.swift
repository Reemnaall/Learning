//
//  Cards.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.
//

import SwiftUI

struct Cards: View {
    let icon: String
   // let days: Int
    let daysText: String
    let description:String
    let iconcolor: Color
    
    var body: some View {
        VStack {
                    Image(systemName: icon)
                    .foregroundStyle(iconcolor)
                    Text(daysText)
                    Text(description)
                }
        .frame(maxWidth:.infinity)
        .padding(20)
        .glassEffect(
        .regular.tint(.black.opacity(0.5)),
            in: RoundedRectangle(cornerRadius: 24))
        
    }
}

