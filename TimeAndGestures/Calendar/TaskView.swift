import SwiftUI

struct TaskView: View {
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
            
            Button(action: {
                isTwinChatPresented = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.appContainer)
                    .font(.system(size: 32))
            }
            .sheet(isPresented: $isTwinChatPresented) {
                TwinChat(task: task)
            }
        }
        .padding()
        .background(task.color)
        .cornerRadius(10)
    }
}
