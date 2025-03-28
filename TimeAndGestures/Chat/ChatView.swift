import SwiftUI

struct ChatView: View {
    @Binding var messages: [Message]
    @Binding var newMessage: String
    
    let sendAction: () -> Void
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(messages) { message in
                            MessageRow(message: message)
                                .id(message.id)
                        }
                    }
                    .onChange(of: messages) { oldValue, newValue in
                        scrollToBottom(proxy)
                    }
                }
            }
            
            MessageInputView(newMessage: $newMessage, sendAction: sendAction)
        }
    }
    
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        if let lastMessage = messages.last {
            withAnimation {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}
