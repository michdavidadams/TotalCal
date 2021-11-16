//
//  Calorie.swift
//  Total Cal WatchKit Extension
//
//  Created by Michael Adams on 11/16/21.
//

import Foundation

struct Calorie: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
