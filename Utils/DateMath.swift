//
//  DateMath.swift
//  
//
//  Created by karaba on 12/8/25.
//

import Foundation

enum DateMath {
    static func wholeDaysBetween(_ from: Date, _ to: Date, inclusive: Bool, calendar: Calendar = .current) -> Int {
        // Normalizamos a medianoche para que los DatePickers no “sumen” por hora
        let start = calendar.startOfDay(for: from)
        let end   = calendar.startOfDay(for: to)
        var components = calendar.dateComponents([.day], from: start, to: end)
        let base = components.day ?? 0
        return inclusive ? base + (base >= 0 ? 1 : -1) : base
    }
}
