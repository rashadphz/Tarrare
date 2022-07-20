//
//  ConvoCell.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/19/22.
//

import Foundation
import UIKit

class ConvoCell : UITableViewCell {
    
    var conversation: Conversation? {
        didSet {
            let currentUser = User.getCurrent()!
            let targetUser =
                conversation?.memberOne == currentUser
                ? conversation?.memberTwo : conversation?.memberOne
            
            let lastMessage = conversation!.messages.last! as Message
            let senderTitle = lastMessage.senderUser == currentUser ? "You" : lastMessage.senderUser.firstName
            
            userNameLabel.text = targetUser?.firstName
            lastMessageLabel.text = "\(senderTitle): \(lastMessage.text)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        contentView.addSubview(profilePictureImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(lastMessageLabel)
        
        profilePictureImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 10, width: 45, height: 45, enableInsets: false)
        userNameLabel.anchor(top: contentView.topAnchor, left: profilePictureImageView.rightAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        lastMessageLabel.anchor(top: userNameLabel.bottomAnchor, left: profilePictureImageView.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    private let profilePictureImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.regular, size: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private let lastMessageLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.regular, size: 17)
        label.textColor = UIColor(named: "LightGray")
        return label
        
    }()
}

