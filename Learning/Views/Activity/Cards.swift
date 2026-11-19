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
        // يرتب الأيقونة والعدد والوصف مع مسافة بينها.
        VStack(spacing: 6) {
                    Image(systemName: icon)
                   // يضبط حجم الخط ووزنه لهذا العنصر.
                   .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(iconcolor)
                    Text(daysText)
                // يضبط حجم الخط ووزنه لهذا العنصر.
                .font(.system(size: 16, weight: .semibold))
                    Text(description)
                // يضبط حجم الخط ووزنه لهذا العنصر.
                .font(.system(size: 12, weight: .regular))
                }
        // يسمح للبطاقة بأخذ المساحة المتاحة داخل الصف.
        .frame(maxWidth:.infinity)
        .padding(20)
        // يطبّق تأثير Liquid Glass الأصلي على شكل العنصر.
        .glassEffect(
        .regular.tint(.black.opacity(0.15)),
            in: RoundedRectangle(cornerRadius: 24))
        
    }
}

