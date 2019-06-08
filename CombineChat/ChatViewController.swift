//
//  ChatViewController.swift
//  CombineChat
//
//  Created by Niklas Holloh on 07.06.19.
//  Copyright © 2019 Thom Ritterfeld. All rights reserved.
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    let service = ChatService()
    let chatCellIdentifier = "ChatMessageCellIdentifier"
    
    @IBOutlet var peerCountBarItem: UIBarButtonItem?
    @IBOutlet var inputField: UITextField?
    @IBOutlet var tableView: UITableView?
    @IBOutlet weak var footerView: UIView!
    
    var keyboardViewDecorator: KeyboardViewDecorator?
    
    var messages = [ChatMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.tableFooterView = UIView()
        
        service.delegate = self
        keyboardViewDecorator = KeyboardViewDecorator(paddedView: footerView, minimumPadding: 0)
        peerCountBarItem?.title = "\(service.session.connectedPeers.count)"
    }
    
    @IBAction func send() {
        if let message = inputField?.text, message.count > 0 {
            service.send(message: message)
            let myMessage = ChatMessage(message: message, username: "Me", my: true)
            addMessage(message: myMessage)
            inputField?.text = nil
            inputField?.resignFirstResponder()
        }
    }
    
    func addMessage(message: ChatMessage) {
        messages.append(message)
        tableView?.reloadData()
    }
}

//MARK: TextfieldDelegate
extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        send()
        return true
    }
}

// MARK: ChatServiceDelegate
extension ChatViewController: ChatServiceDelegate {
    func connectedDevicesChanged(manager: ChatService, connectedDevices: [String]) {
        DispatchQueue.main.async {
            self.peerCountBarItem?.title = "\(connectedDevices.count)"
        }
    }
    
    func messageReceived(manager: ChatService, message: ChatMessage) {
        DispatchQueue.main.async {
            self.addMessage(message: message)
        }
    }
}

// MARK: UITableView Magic
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatCellIdentifier) as? ChatMessageCell
        let chatMessage = messages[indexPath.row]
        cell?.configure(chat: chatMessage)
        return cell!
    }
    
    
}
