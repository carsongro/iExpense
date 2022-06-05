//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Carson Gross on 6/5/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
