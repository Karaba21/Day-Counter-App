//
//  DayCounterWidgetLiveActivity.swift
//  DayCounterWidget
//
//  Created by karaba on 12/8/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DayCounterWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct DayCounterWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DayCounterWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension DayCounterWidgetAttributes {
    fileprivate static var preview: DayCounterWidgetAttributes {
        DayCounterWidgetAttributes(name: "World")
    }
}

extension DayCounterWidgetAttributes.ContentState {
    fileprivate static var smiley: DayCounterWidgetAttributes.ContentState {
        DayCounterWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: DayCounterWidgetAttributes.ContentState {
         DayCounterWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: DayCounterWidgetAttributes.preview) {
   DayCounterWidgetLiveActivity()
} contentStates: {
    DayCounterWidgetAttributes.ContentState.smiley
    DayCounterWidgetAttributes.ContentState.starEyes
}
