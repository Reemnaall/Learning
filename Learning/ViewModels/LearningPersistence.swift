import Foundation

// يتولى تحويل بيانات التطبيق وحفظها واستعادتها.
struct LearningPersistence {    // دالة الحفظ
    // اسم موحّد للوصول إلى نفس البيانات عند الحفظ والتحميل.
    private let key = "learning.savedData"

    // يحفظ حزمة الهدف وسجل الأيام في UserDefaults.
    func save(_ savedData: SavedLearningData) throws {
        // يحوّل المودل إلى بيانات يمكن تخزينها.
        let data = try PropertyListEncoder().encode(savedData)
        // يستبدل البيانات المحفوظة تحت المفتاح بالنسخة الحالية.
        UserDefaults.standard.set(data, forKey: key)
    }
    
    
    // يستعيد الحزمة المحفوظة أو يرجع nil عند غيابها.
    func load() throws -> SavedLearningData? {    // دالة التحميل
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        // يفك البيانات إلى الهدف وسجل الأيام بأنواعهما الأصلية.
        return try PropertyListDecoder().decode(SavedLearningData.self, from: data)
    }
    // يجمع الهدف والسجل ثم يحفظهما مع معالجة خطأ التحويل.
    func saveLearningData(  //الدالة تستقبل الهدف والسجل، تجمعهم في SavedLearningData، وتستدعي save اللي كتبناها قبل. لو فشل التحويل، تطبع الخطأ من نفس ملف الحفظ
        currentGoal: LearningGoal?,
        entriesByDate: [Date: DayEntry]
    ) {
        let savedData = SavedLearningData(
            currentGoal: currentGoal,
            entriesByDate: entriesByDate
        )

        do {
            try save(savedData)
        } catch {
            print("Could not save Learning data: \(error)")
        }
    }
}
