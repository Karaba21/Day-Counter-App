//
//  DayCounterViewModel.swift
//  
//
//  Created by karaba on 12/8/25.
//

import Foundation
import SwiftUI

final class DayCounterViewModel: ObservableObject {
    @AppStorage("dayCounter_data") private var storedData: Data = Data()

    @Published var title: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var inclusive: Bool
    @Published var mode: DayCounter.Mode

    init() {
        // Default: “hasta fin de año”
        let now = Date()
        let cal = Calendar.current
        let yearEnd = cal.date(from: DateComponents(year: cal.component(.year, from: now), month: 12, day: 31)) ?? now

        if let decoded = try? JSONDecoder().decode(DayCounter.self, from: storedData) {
            self.title = decoded.title
            self.startDate = decoded.startDate
            self.endDate = decoded.endDate
            self.inclusive = decoded.inclusive
            self.mode = decoded.mode
        } else {
            self.title = "Hasta fin de año"
            self.startDate = now
            self.endDate = yearEnd
            self.inclusive = false
            self.mode = .until
            persist()
        }
    }

    var days: Int {
        switch mode {
        case .until:
            return DateMath.wholeDaysBetween(Date(), endDate, inclusive: inclusive)
        case .since:
            return DateMath.wholeDaysBetween(startDate, Date(), inclusive: inclusive)
        }
    }

    var subtitle: String {
        switch mode {
        case .until:
            return days >= 0 ? "días restantes" : "días desde la fecha objetivo"
        case .since:
            return days >= 0 ? "días desde el evento" : "días hasta el evento"
        }
    }

    func asModel() -> DayCounter {
        DayCounter(title: title, startDate: startDate, endDate: endDate, inclusive: inclusive, mode: mode)
    }

    func persist() {
        if let data = try? JSONEncoder().encode(asModel()) {
            storedData = data
        }
    }
}
