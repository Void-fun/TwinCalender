import SwiftUI

struct EventModal: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var location: String = ""
    @State private var isAllDay = false
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3600)
    @State private var url: String = ""
    @State private var notes: String = ""
    @State private var selectedSegment = 0
    
    private let segments = ["Event", "Reminder"]
    
    var body: some View {
        NavigationView {
            List {
                Picker("Type", selection: $selectedSegment) {
                    ForEach(0...1, id: \.self) { index in
                        Text(segments[index]).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                
                Section {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Location", text: $location)
                }
                .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
                
                Section {
                    Toggle("All Day", isOn: $isAllDay)
                    
                    HStack {
                        Text("Starts")
                        Spacer()
                        DatePicker(
                            "",
                            selection: $startDate,
                            displayedComponents: isAllDay ? .date : [.date, .hourAndMinute]
                        )
                        .labelsHidden()
                    }
                    
                    HStack {
                        Text("Ends")
                        Spacer()
                        DatePicker(
                            "",
                            selection: $endDate,
                            in: startDate...,
                            displayedComponents: isAllDay ? .date : [.date, .hourAndMinute]
                        )
                        .labelsHidden()
                    }
                    
                    HStack {
                        Text("Travel Time")
                        Spacer()
                        Text("None")
                            .foregroundColor(.gray)
                    }
                }
                .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
                
             
                
                Section {
                        HStack {
                            Text("Calendar")
                            Spacer()
                            Circle()
                                .fill(Color.red)
                                .frame(width: 10, height: 10)
                            Text("Home")
                                .foregroundColor(.gray)
                        }
                    
                        HStack {
                            Text("Invitees")
                            Spacer()
                            Text("None")
                                .foregroundColor(.gray)
                        }
                }
                .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
                
                Section {
                   
                        HStack {
                            Text("Alert")
                            Spacer()
                            Text("None")
                                .foregroundColor(.gray)
                        }
                }
                .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
                
                Section {
                    Button(action: {
                        // Add attachment action
                    }) {
                        Text("Add attachment...")
                    }
                }
                .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
                
                Section {
                    TextField("URL", text: $url)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .frame(minHeight: 100, alignment: .top)
                }
                .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview("Light Mode") {
    EventModal()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    EventModal()
        .preferredColorScheme(.dark)
}

