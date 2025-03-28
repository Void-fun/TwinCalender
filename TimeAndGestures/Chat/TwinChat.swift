import SwiftUI

struct TwinChat: View {
    let task: CalendarTask
    @State private var messages: [Message] = []
    @State private var newMessage: String = ""
    @State private var showingSidebar = false

    var body: some View {
        TaskView(task: task)
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(messages) { message in
                            MessageRow(message: message)
                        }
                    }
                    .padding()
                }
                
                MessageInputView(newMessage: $newMessage, sendAction: sendMessage)
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        withAnimation {
//                            showingSidebar.toggle()
//                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//                        }
//                    }) {
//                        Image(systemName: "sidebar.left")
//                    }
//                }
//            }
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        // Добавляем сообщение пользователя
        let userMessage = Message(text: newMessage, isUser: true)
        messages.append(userMessage)
        
        // Симулируем ответ бота
        let botResponse = Message(text: "Ответ на: \(newMessage)", isUser: false)
        messages.append(botResponse)
        
        // Очищаем поле ввода
        newMessage = ""
    }
}
