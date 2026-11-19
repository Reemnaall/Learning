//
//  goalItem.swift
//  Learning
//
//  Created by reem on 02/06/1448 AH.
//
import Foundation

// مدد الهدف المتاحة مع دعم التكرار والحفظ.
enum LearningDuration: String, CaseIterable,Codable{
    
    case week
    case month
    case year
    // يعرض اسم المدة بحرف أول كبير.
    var title: String { rawValue.capitalized } // خاصيه محسوبه
}
