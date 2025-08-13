//
//  DayCounterWidgetBundle.swift
//  DayCounterWidget
//
//  Created by karaba on 12/8/25.
//

import WidgetKit
import SwiftUI

@main
struct DayCounterWidgetBundle: WidgetBundle {
    var body: some Widget {
        DayCounterWidget()
        DayCounterWidgetControl()
        DayCounterWidgetLiveActivity()
    }
}
