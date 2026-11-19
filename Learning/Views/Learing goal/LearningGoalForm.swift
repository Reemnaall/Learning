//
//  LearningGoalForm.swift
//  MyApp
//
//  Created by reem on 01/06/1448 AH.
//

import SwiftUI

struct LearningGoalForm: View {
    // يربط حقل الاسم بمسودة الشاشة التي تستخدم النموذج.
    @Binding  var subject:String
    // يربط اختيار المدة بمسودة النموذج المشتركة.
    @Binding var duration: LearningDuration?
    
    var body: some View {
        
        Text("I want to learn")
            .foregroundStyle(.primary)
            .font(.callout)
            .padding(.bottom, 5)
        TextField("swift",text: $subject)
            .frame(minHeight: 48)
        Divider()
            .padding(.bottom, 30)
        Text("I want to learn it in a")
            .padding(.bottom, 13)
            .foregroundStyle(.primary)
            .font(.callout)
        
        HStack(spacing: 12) {
            // يرسم زرًا لكل مدة متاحة.
            ForEach(LearningDuration.allCases, id: \.self) { option in
                // يميّز المدة المختارة بنمط الزجاج البارز.
                if duration == option {
                    Button(option.title) { duration = option }
                        .buttonStyle(.glassProminent)
                } else {
                    Button(option.title) { duration = option }
                        .buttonStyle(.glass)
                        .foregroundStyle(.secondary)
                }
            }
        }
        // يجعل عرض الزر مناسبًا للنص ومساحته الداخلية.
        .buttonSizing(.fitted)
        // يطلب حجم التحكم الكبير من النظام.
        .controlSize(.large)
        .font(.body)
        .fontWeight(.medium)
        // يجعل الإجراء افتراضيًا عند استخدام مفتاح Return.
        .keyboardShortcut(.defaultAction)
    
    }
        
        
    }
    

