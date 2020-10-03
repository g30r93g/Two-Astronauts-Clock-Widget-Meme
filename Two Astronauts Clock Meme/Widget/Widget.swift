//
//  Widget.swift
//  Widget
//
//  Created by George Nick Gorzynski on 03/10/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date().zeroSeconds!
        
        for i in 0..<10 {
            entries.append(SimpleEntry(date: currentDate.addingTimeInterval(TimeInterval(i * 60))))
        }
        
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WidgetEntryView: View {
    
    var entry: Provider.Entry
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
                Text("Wait, it's")
                    .font(.custom("RobotoMonoForPowerline-Medium", size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.80075246, green: 0.8225293, blue: 0.84079504))
                    .frame(width: 110, height: 18)
                    .offset(x: 15, y: 0)
                
                HStack {
//                    Text(self.determineTimeString())
                    Text(self.entry.date, style: .time)
                        .font(.custom("RobotoMonoForPowerline-Medium", size: 36))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("?")
                        .font(.custom("RobotoMonoForPowerline-Medium", size: 12))
                        .foregroundColor(Color(red: 0.80075246, green: 0.8225293, blue: 0.84079504))
                        .offset(x: -5, y: -5)
                    
                }
                
                Text("Always has been")
                    .font(.custom("RobotoMonoForPowerline-Medium", size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.80075246, green: 0.8225293, blue: 0.84079504))
                    .frame(width: 126.5, height: 16.5)
                    .offset(x: -15, y: 0)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .background(Color(#colorLiteral(red: 0.06647213548, green: 0.08272323757, blue: 0.1096622124, alpha: 1)))
            
            Image("firstAstronaut")
                .resizable()
                .frame(width: 60, height: 60, alignment: .leading)
                .offset(x: 0, y: 10)
            
            Image("secondAstronaut")
                .resizable()
                .frame(width: 65, height: 65, alignment: .leading)
                .offset(x: geometry.size.width - 62, y: geometry.size.height - 75)
        }
    }
    
    private func determineTimeString() -> String {
        let currentTimeFormatter = DateFormatter()
        currentTimeFormatter.dateFormat = "HH:mm"
        
        let currentTime = currentTimeFormatter.string(from: Date())
        
        return currentTime
    }
    
}

@main
struct ClockWidget: Widget {
    let kind: String = "Clock Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Clock")
        .description("This is a clock widget for the two astronauts meme.")
        .supportedFamilies([.systemSmall])
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
