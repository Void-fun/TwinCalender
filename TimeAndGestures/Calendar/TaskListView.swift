import SwiftUI

struct TaskListView: View {
    let tasks: [CalendarTask]
    let selectedDate: Date
    
    @State private var initialScrollPerformed = false
    @State private var timeSlotScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    private let minScale: CGFloat = 0.5
    private let maxScale: CGFloat = 2.0
    private let defaultHourSpacing: CGFloat = 40
    private let timelineHourHeight: CGFloat = 30
    
    private var hourSpacing: CGFloat {
        defaultHourSpacing * timeSlotScale
    }

    private func taskOffset(for task: CalendarTask) -> CGFloat {
        let calendar = Calendar.current
        guard let startTime = task.startTime else { return 0 }
        
        let components = calendar.dateComponents([.hour, .minute], from: startTime)
        let hour = CGFloat(components.hour ?? 0)
        let minute = CGFloat(components.minute ?? 0)
        
        return (hour + minute / 60) * (hourSpacing + timelineHourHeight)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(dateFormatter.string(from: selectedDate))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.appTextPrimary)
                
                Text("You have \(tasks.count) tasks scheduled for today")
                    .font(.callout)
                    .foregroundColor(.appTextSecondary)
            }
            GeometryReader { geometry in
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 16) {
                            TimelineView(hourSpacing: hourSpacing)
                            
                            CurrentTimeIndicator(hourSpacing: hourSpacing)
                            
                            ZStack(alignment: .top) {
                                ForEach(tasks) { task in
                                    TaskView(task: task)
                                        .offset(y: taskOffset(for: task))
                                }
                            }
                        }
                        .frame(minHeight: geometry.size.height)
                    }
                    .onAppear {
                        if !initialScrollPerformed {
                            let calendar = Calendar.current
                            let currentHour = calendar.component(.hour, from: Date())
                            
                            let targetHour = max(currentHour - 2, 0)
                            
                            scrollProxy.scrollTo("hour-\(targetHour)", anchor: .top)
                            initialScrollPerformed = true
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            ZStack {
                Color.appContainer
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.appBorder, lineWidth: 1)
            }
        )
        .cornerRadius(20)
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    let delta = value / lastScale
                    lastScale = value
                    
                    let newScale = timeSlotScale * delta
                    timeSlotScale = min(maxScale, max(minScale, newScale))
                }
                .onEnded { value in
                    lastScale = 1.0
                }
        )
        .simultaneousGesture(
            TapGesture(count: 2)
                .onEnded { _ in
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        timeSlotScale = 3.0
                        lastScale = 1.0
                    }
                }
        )
        .simultaneousGesture(
            TapGesture(count: 1)
                .onEnded { _ in
                    if timeSlotScale != 1.0 {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            timeSlotScale = 1.0
                            lastScale = 1.0
                        }
                    }
                }
        )
        .animation(.interactiveSpring(
            response: 0.3, dampingFraction: 0.7, blendDuration: 0.1
        ), value: timeSlotScale)
    }
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter
    }()
}
