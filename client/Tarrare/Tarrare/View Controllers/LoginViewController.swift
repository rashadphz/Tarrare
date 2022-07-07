//
//  LoginViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/6/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(containerView)
        containerView.addSubview(loginLabel)
        containerView.addSubview(loginToContinueLabel)
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(loginButton)
        
        self.view.addSubview(footerView)
        footerView.addSubview(noAccountLabel)
    }
    
    
    override func viewWillLayoutSubviews() {
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 30.0
        
        containerView.anchor(top: nil, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight/2, enableInsets: false)
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        loginLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 0, enableInsets: false)
        
        loginToContinueLabel.anchor(top: loginLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 0, enableInsets: false)
        
        emailField.anchor(top: loginToContinueLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        passwordField.anchor(top: emailField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        
        loginButton.anchor(top: passwordField.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 40, enableInsets: false)
        
        footerView.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 90, enableInsets: false)
        noAccountLabel.anchor(top: footerView.topAnchor, left: footerView.leftAnchor, bottom: footerView.bottomAnchor, right: footerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
    }
    
    private let containerView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let loginLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Bold", size: 30)
        label.text = "Login"
        return label
    }()
    
    private let loginToContinueLabel : UILabel = {
        let label = UILabel()
        label.text = "Please login to continue"
        label.font = UIFont(name: "Inter-Regular_Bold", size: 15)
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    private let emailField : UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Inter-Regular_Bold", size: 15)
        field.textColor = .black
        field.backgroundColor = .white
        field.layer.cornerRadius = 5;
        field.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        field.layer.borderWidth = 2.0
        field.placeholder = "EMAIL"
        
        let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 30, height: 30))
        imageView.image = UIImage(systemName: "mail")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.addSubview(imageView)
        
        field.leftViewMode = UITextField.ViewMode.always
        field.leftViewMode = .always
        field.leftView = view
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        
        return field
        
    }()
    
    private let passwordField : UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Inter-Regular_Bold", size: 15)
        field.textColor = .black
        field.backgroundColor = .white
        field.layer.cornerRadius = 5;
        field.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        field.layer.borderWidth = 2.0
        field.isSecureTextEntry = true
        field.placeholder = "PASSWORD"
        
        let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 30, height: 30))
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.addSubview(imageView)
        
        field.leftViewMode = UITextField.ViewMode.always
        field.leftViewMode = .always
        field.leftView = view
        return field
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular_Bold", size: 16)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        return view;
    }()
    
    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign up"
        label.font = UIFont(name: "Inter-Regular_Bold", size: 15)
//        label.textColor = UIColor(named: "LightGray")
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()
    
    
}
