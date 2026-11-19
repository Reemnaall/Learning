//
//  Update Learning goal.swift
//  MyApp
//
//  Created by reem on 29/05/1448 AH.
//

import SwiftUI

struct Update_Learning_goal: View {
    // يسمح بربط الحقول بخصائص ViewModel مباشرة.
    @Bindable var vm: OnboardingViewModel
    // يأخذ إجراء إغلاق الصفحة من SwiftUI.
    @Environment(\.dismiss) private var dismiss
    // يتابع هل تنبيه تأكيد التحديث مفتوح.
    @State private var showsUpdateAlert = false
    var body: some View {
        
        VStack(alignment: .leading){
            LearningGoalForm(subject: $vm.subject, duration: $vm.duration )
        }
                .padding(EdgeInsets(top: 36, leading: 17, bottom: 0, trailing: 17))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .navigationTitle(" Learning Goal")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            // يغلق صفحة التعديل ويرجع إلى النشاط.
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                        
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // يظهر التنبيه قبل حفظ الهدف.
                            showsUpdateAlert = true
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                      //.tint(.orange)
                        // يجعل الإجراء افتراضيًا عند استخدام مفتاح Return.
                        .keyboardShortcut(.defaultAction)
                        // يمنع الضغط إذا الاسم أو المدة غير جاهزين.
                        .disabled(!vm.canStart)
                    }
                    
                }
                // يعرض تأكيد التحديث ويربط فتحه بحالة التنبيه.
                .alert("Update goal", isPresented: $showsUpdateAlert) {
                    // يلغي التنبيه مع الاحتفاظ بمسودة النموذج.
                    Button("Dismiss", role: .cancel) {}
                   // Button("Update") {
                        Button("Update") {
                            // يتحقق من النموذج وينشئ الهدف بالبيانات المكتوبة.
                            vm.startLearning()//تتحقق من الاسم والمدة، ثم تنشئ الهدف بهوية وبداية جديدتين.
                            // يغلق صفحة التعديل ويرجع إلى النشاط.
                            dismiss()
                        }
                        // يجعل الإجراء افتراضيًا عند استخدام مفتاح Return.
                        .keyboardShortcut(.defaultAction)
                   
                } message: {
                    Text("If you update now, your streak will start over.")
                }
            }
    
}
