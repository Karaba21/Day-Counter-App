//
//  DayCounterWidget.swift
//  
//
//  Created by karaba on 12/8/25.
//

import WidgetKit
import SwiftUI

struct CounterEntry: TimelineEntry {
    let date: Date
    let title: String
    let value: Int
    let subtitle: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry(date: .now, title: "Hasta fin de año", value: 142, subtitle: "días restantes")
    }

    func getSnapshot(in context: Context, completion: @escaping (CounterEntry) -> Void) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CounterEntry>) -> Void) {
        let entry = loadEntry()
        // Actualizar cada 1 hora está de más para días, pero es seguro
        let next = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func loadEntry() -> CounterEntry {
        // Leemos el mismo AppStorage que usa la app
        let defaults = UserDefaults(suiteName: "group.daycounter.shared") ?? .standard
        let data = defaults.data(forKey: "dayCounter_data") ?? Data()

        let model: DayCounter? = (try? JSONDecoder().decode(DayCounter.self, from: data))
        let title = model?.title ?? "Contador"
        let inclusive = model?.inclusive ?? false
        let mode = model?.mode ?? .until

        let value: Int
        let subtitle: String
        switch mode {
        case .until:
            let end = model?.endDate ?? Date()
            value = DateMath.wholeDaysBetween(Date(), end, inclusive: inclusive)
            subtitle = value >= 0 ? "días restantes" : "días desde"
        case .since:
            let start = model?.startDate ?? Date()
            value = DateMath.wholeDaysBetween(start, Date(), inclusive: inclusive)
            subtitle = value >= 0 ? "días desde" : "días hasta"
        }

        return CounterEntry(date: .now, title: title, value: value, subtitle: subtitle)
    }
}

struct DayCounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.clear
            VStack(spacing: 4) {
                Text(entry.title)
                    .font(.caption).lineLimit(1)
                Text("\(entry.value)")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text(entry.subtitle)
                    .font(.caption2).foregroundStyle(.secondary)
            }
            .padding(8)
        }
    }
}

struct DayCounterWidget: Widget {
    let kind: String = "DayCounterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DayCounterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Contador de días")
        .description("Muestra tu contador en la pantalla de inicio.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    DayCounterWidget()
} timeline: {
    CounterEntry(date: .now, title: "Ejemplo", value: 42, subtitle: "días restantes")
}
