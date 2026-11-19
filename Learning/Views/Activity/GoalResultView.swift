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
    var onSetGoal: () -> Void = {}
    
    var body: some View {
        VStack(spacing:0){
            
            Image(systemName: iconName)
                // يضبط حجم الخط ووزنه لهذا العنصر.
                .font(.system(size: 40, weight: .regular))
                .foregroundStyle(.orange)
                .padding(.bottom, 19)
            Text(title)
                // يضبط حجم الخط ووزنه لهذا العنصر.
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
            Text(subtitle)
                // يضبط حجم الخط ووزنه لهذا العنصر.
                .font(.system(size: 14, weight:.medium))
                .foregroundStyle(.secondary)
            
            Button {
                
                // يشغّل نفس مسار فتح نموذج الهدف الجديد.
                onSetGoal()
                
            } label: {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .font(.body.weight(.medium))
                    .foregroundStyle(.primary)
            }
            .buttonStyle(.borderedProminent)
            // يطلب حجم التحكم الكبير من النظام.
            .controlSize(.large)
            .buttonBorderShape(.capsule)
            // يجعل الإجراء افتراضيًا عند استخدام مفتاح Return.
            .keyboardShortcut(.defaultAction)
            // .tint(.orange)
            .padding(.top, 68)
            
            
        }
    }}
    
