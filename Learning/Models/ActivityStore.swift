//
//  ActivityStore.swift
//  Learning
//
//  Created by reem on 04/06/1448 AH.
//

import Foundation
import Observation

@Observable final class ActivityStore {// عشان نشارك نسخه مع الكالندر والاكتفيتي
   var entriesByDate: [Date: DayEntry] = [:]
}
