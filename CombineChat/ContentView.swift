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
        service.send(message: textToSend)
        textToSend = ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                EmptyView().onAppear {
                    self.service.delegate = self
                }
                
                List(0...1) { item in
                    Text("Incoming Message")
                }
                
                HStack {
                    TextField($textToSend,
                              placeholder: Text("Message"),
                              onEditingChanged: {_ in }) {
                                self.sendText()
                    }
                }
                }
                .padding(.bottom)
                .navigationBarTitle(Text("Combine Chat"))
        }
    }
}

extension ContentView: ChatServiceDelegate {
    func connectedDevicesChanged(manager: ChatService, connectedDevices: [String]) {
        
    }
    
    func messageReceived(manager: ChatService, message: ChatMessage) {
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(textToSend: .constant(""), messages: [])
    }
}
#endif
