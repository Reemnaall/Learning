//
//  goalItem.swift
//  Learning
//
//  Created by reem on 02/06/1448 AH.
//
import Foundation

enum LearningDuration: String, CaseIterable,Codable{
    
    case week
    case month
    case year
    var title: String { rawValue.capitalized } // خاصيه محسوبه
}
