//
//  ContentView.swift
//  CombineChat
//
//  Created by Thom Ritterfeld on 6/7/19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var service = ChatService()
    
    @Binding var textToSend: String
    @State var messages: [ChatMessage]
    
    func sendText() {
        service.send(message: "Message!!!")
        messages.append(ChatMessage(message: textToSend, username: "Me"))
        
        textToSend = ""
        UIApplication.shared.keyWindow?.endEditing(true)
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(messages) { chatMessage in
                    MessageRow(chatMessage: chatMessage)
                }
                
                HStack {
                    TextField($textToSend,
                              placeholder: Text("Message"),
                              onEditingChanged: {_ in
                                print("Editing changed")
                    }) {
                        self.sendText()
                    }
                }
                }
                .padding(.bottom)
                .navigationBarTitle(Text("Combine Chat"))
        }
            .onAppear {
                self.service.delegate = self
        }
    }
}

extension ContentView: ChatServiceDelegate {
    func connectedDevicesChanged(manager: ChatService, connectedDevices: [String]) {
        
    }
    
    func messageReceived(manager: ChatService, message: ChatMessage) {
        messages.append(message)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(textToSend: .constant(""), messages: [ChatMessage(message: "Hello world", username: "Thommyboy")])
    }
}
#endif
