import SwiftUI

struct ChatTaskView: View {
    let task: CalendarTask
    @State private var isTwinChatPresented = false
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.appTextPrimary)
                
                Text(task.description)
                    .font(.caption)
                    .foregroundColor(.appTextSecondary)
            }
            Spacer()
        }
        .padding()
        .background(task.color)
        .cornerRadius(10)
    }
}
