//
//  DayCounterModels.swift
//  
//
//  Created by karaba on 12/8/25.
//

import Foundation

struct DayCounter: Codable, Equatable {
    var title: String
    var startDate: Date
    var endDate: Date
    var inclusive: Bool   // cuenta el día final si está activo
    var mode: Mode       // .until = faltan, .since = desde que pasó

    enum Mode: String, Codable, CaseIterable {
        case until  // cuenta días hacia un objetivo (futuros)
        case since  // cuenta días desde un evento (pasado)
    }
}
