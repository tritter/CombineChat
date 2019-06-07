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

    func configure(chat: ChatMessage) {
        usernameLabel?.text = chat.username
        messageLabel?.text = chat.message
    }
    
}
