//
//  OpenChatsViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/18/22.
//

import Foundation
import UIKit

class ConversationsViewController : UIViewController, UITableViewDelegate {
    var conversationArray : [Conversation] = [Conversation]()
    let currentUser: User? = User.getCurrent()
    
    // MARK: - View Layouts
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchConversations()
        view.backgroundColor = .white
        title = "Chats"
        conversationTableView.dataSource = self
        conversationTableView.delegate = self
        
        view.addSubview(containerView)
        containerView.addSubview(conversationTableView)
        
        startMessageListener()
        
    }
    
    override func viewWillLayoutSubviews() {
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 10.0
        
        containerView.anchor(top: navigationController?.navigationBar.bottomAnchor, left: view.leftAnchor, bottom: tabBarController?.tabBar.topAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight, enableInsets: false)
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        conversationTableView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: containerView.frame.width, height: containerView.frame.height, enableInsets: false)
    }
    
    //MARK: - Helpers
    
    // remove the convo, replace it at start of the array
    func updateConversationList(message: Message){
        let newMessageConvoId = message.convoId
        
        if let index = self.conversationArray.firstIndex(where: {$0.id == newMessageConvoId}) {
            let removedConvo = self.conversationArray.remove(at: index)
            removedConvo.messages.append(message)
            self.conversationArray.insert(removedConvo, at: 0)
        } else {
            // if the message is part of a new convo, refetch all convos
            fetchConversations()
        }
        self.conversationTableView.reloadData()
    }
    
    
    // MARK: - API Requests
    func fetchConversations() {
        Conversation.fetchConversationsForUserId(currentUser!.id) { conversations in
            if let conversations = conversations {
                self.conversationArray = conversations
                self.conversationTableView.reloadData()
            }
            
        }
    }
    
    // listen for a message, update conversation list accordingly
    func startMessageListener() {
        Message.messageListenForUserId(currentUser!.id, completion: {newMessage in
            guard let newMessage = newMessage else {
                return
            }
            self.updateConversationList(message: newMessage)
        })
    }
    
    // MARK: - Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let conversationTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        
        tableView.register(ConvoCell.self, forCellReuseIdentifier: "ConvoCell")
        return tableView
    }()
    
    // MARK: - Gestures/Actions
    
    func didTapConvoCell(_ conversation: Conversation) {
        let currentUser = User.getCurrent()!
        let tappedUser =
            conversation.memberOne == currentUser
            ? conversation.memberTwo : conversation.memberOne
        
        let individualChatVC = IndividualChatViewController()
        individualChatVC.targetUser = tappedUser
        self.navigationController?.pushViewController(individualChatVC, animated: true)
    }
    
}

extension ConversationsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConvoCell", for: indexPath) as! ConvoCell
        let currentConversation = conversationArray[indexPath.row]
        cell.conversation = currentConversation
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversationArray[indexPath.row]
        self.didTapConvoCell(conversation)
    }
}

