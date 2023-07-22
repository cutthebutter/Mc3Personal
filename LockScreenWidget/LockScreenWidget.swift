//
//  LockScreenWidget.swift
//  LockScreenWidget
//
//  Created by semini on 2023/07/23.
//

import WidgetKit
import SwiftUI
import Intents

struct OpenAppLockScreenProvider: TimelineProvider {
    func placeholder(in context: Context) -> OpenAppLockScreenEntry {
        OpenAppLockScreenEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (OpenAppLockScreenEntry) -> ()) {
        let entry = OpenAppLockScreenEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [OpenAppLockScreenEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = OpenAppLockScreenEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct OpenAppLockScreenEntry: TimelineEntry {
    let date: Date
}

struct OpenAppLockScreenEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: OpenAppLockScreenProvider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            ZStack{
                AccessoryWidgetBackground()
                Image(systemName: "note.text.badge.plus")
                    .tint(.white)
            }
            
        default :
            Text("not implemented")
        }
    }
}

struct LockScreenWidget: Widget {
    let kind: String = "OpenAppLockScreen"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: OpenAppLockScreenProvider()) { entry in
            OpenAppLockScreenEntryView(entry: entry)
        }

        // 추가할 때 설명을 작성.
        .configurationDisplayName("메모앱")
        .description("메모앱을 실행합니다..")

        //accessoryCircular 만 지원.
        .supportedFamilies([.accessoryCircular])
    }
}

struct LockScreenWidget_Previews: PreviewProvider {
    static var previews: some View {
        OpenAppLockScreenEntryView(entry: OpenAppLockScreenEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
