//
//  ContentView.swift
//  CombineChat
//
//  Created by Thom Ritterfeld on 6/7/19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    let service = ChatService()
    
    @Binding var textToSend: String
    @State var messages: [ChatMessage]
    
    func sendText() {
        service.send(chat: textToSend)
        textToSend = ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(0...1) { item in
                    Text("Incoming Message")
                }
                HStack {
                    TextField($textToSend,
                              placeholder: Text("Message"),
                              onEditingChanged: {_ in }) {
                                
                    }
                }
            }
            .padding(.bottom)
        }.navigationBarTitle(Text("Combine Chat"))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(textToSend: .constant(""))
    }
}
#endif
