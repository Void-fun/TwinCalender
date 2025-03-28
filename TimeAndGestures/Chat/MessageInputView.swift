import SwiftUI

struct MessageInputView: View {
    @Binding var newMessage: String
    let sendAction: () -> Void
    
    var body: some View {
        HStack {
            TextField("Введите сообщение...", text: $newMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: sendAction) {
                Text("Отправить")
            }
            .padding(.leading, 5)
        }
        .padding()
    }
}
