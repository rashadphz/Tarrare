//
//  ProfileViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/8/22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.backgroundColor = .white
        
        setUser()
        
        view.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(logoutButton)
        
        headerView.addSubview(nameLabel)
        addLogoutButtonGesture()
    }
    
    override func viewDidLayoutSubviews() {
        let displayWidth = view.frame.width
        let displayHeight = view.frame.height
        
        let sidePadding = 20.0
        
        containerView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight, enableInsets: false)
        
        headerView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 100, enableInsets: false)
        
        logoutButton.anchor(top: headerView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        
        
        nameLabel.anchor(top: headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 0, enableInsets: false)
    }
    
    func setUser(){
        let currentUser = User.getCurrent()
        if let user = currentUser {
            self.nameLabel.text = "\(user.firstName) \(user.lastName)"
            
        }
    }
    
    private let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let headerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Bold", size: 25)
        return label
    }()
    
    private let logoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("LOGOUT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular_Bold", size: 16)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
    }()
    
    func presentLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: false)
    }
    
    
    func addLogoutButtonGesture() {
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    @objc func didTapLogoutButton() {
        APIManager.shared().logoutUser(completion: {successful in
            if (successful) {
                self.presentLoginScreen()
            }
        })
    }
}
