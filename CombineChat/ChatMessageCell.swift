//
//  MessageCell.swift
//  CombineChat
//
//  Created by Thom Ritterfeld on 6/7/19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import Foundation
import UIKit

class ChatMessageCell: UITableViewCell {
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var messageBubble: BubbleView?
    
    func configure(chat: ChatMessage) {
        usernameLabel?.text = chat.username
        messageLabel?.text = chat.message
        if chat.my {
            messageLabel?.textColor = UIColor.white
            messageBubble?.backgroundColor = UIColor.systemBlue
        } else {
            messageLabel?.textColor = UIColor.black
            messageBubble?.backgroundColor = UIColor.groupTableViewBackground
        }
        messageBubble?.layoutLeft?.isActive = !chat.my
        messageBubble?.layoutRight?.isActive = chat.my

    }
    
}
