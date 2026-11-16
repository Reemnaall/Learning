import Foundation

struct LearningPersistence {    // دالة الحفظ
    private let key = "learning.savedData"

    func save(_ savedData: SavedLearningData) throws {
        let data = try PropertyListEncoder().encode(savedData)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    
    func load() throws -> SavedLearningData? {    // دالة التحميل
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        return try PropertyListDecoder().decode(SavedLearningData.self, from: data)
    }
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
