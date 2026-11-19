//
//  DayItem.swift
//  MyApp
//
//  Created by reem on 30/05/1448 AH.


import Foundation

// تاريخ اليوم وحالته مع هوية لعرضه في صف الأسبوع.
struct DayItem: Identifiable {
    
    let status:DayStatus
    let  date:Date
    // يستخدم تاريخ اليوم لتمييز خانته في ForEach.
    var id:Date{
        
        date 
    }
}
