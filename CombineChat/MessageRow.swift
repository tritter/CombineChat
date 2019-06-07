//
//  MessageRow.swift
//  CombineChat
//
//  Created by Niklas Holloh on 07.06.19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import SwiftUI

struct MessageRow : View {
    @State var chatMessage: ChatMessage
    
    var body: some View {
        VStack {
            HStack {
                Text(chatMessage.username)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Spacer()
                Text(chatMessage.message)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

#if DEBUG
struct MessageRow_Previews : PreviewProvider {
    static var previews: some View {
        MessageRow(chatMessage: ChatMessage(message: "message", username: "author"))
    }
}
#endif
