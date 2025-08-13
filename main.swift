//
//  main.swift
//  
//
//  Created by karaba on 12/8/25.
//

import SwiftUI

@main
struct DayCounterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}

