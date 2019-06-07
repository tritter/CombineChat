//
//  Message.swift
//  CombineChat
//
//  Created by Thom Ritterfeld on 6/7/19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import Foundation
import SwiftUI

struct ChatMessage: Identifiable {
    var id: Int {
        return message.hashValue
    }
    
    let message: String
    let username: String
}
