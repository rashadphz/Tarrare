//
//  HomeViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/8/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Home"
        
        self.createNavBar()
        view.addSubview(navBar)
        customNavBarView.addSubview(orderNavButton)
        customNavBarView.addSubview(deliverNavButton)
        customNavBarView.frame = CGRect(x: 0, y:0, width: view.frame.width, height: 200)
        
        view.addSubview(containerView)
        containerView.addSubview(locationSelectView)
        locationSelectView.addSubview(currentLocationLabel)
        
        addCurrentLocationLabelGesture()
    }
    
    override func viewWillLayoutSubviews() {
        orderNavButton.anchor(top: customNavBarView.topAnchor, left: customNavBarView.leftAnchor, bottom: customNavBarView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 70, height: 30, enableInsets: false)
        deliverNavButton.anchor(top: customNavBarView.topAnchor, left: orderNavButton.rightAnchor, bottom: customNavBarView.bottomAnchor, right: customNavBarView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 70, height: 30, enableInsets: false)
        
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 20.0
        
        containerView.anchor(top: navBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight/2, enableInsets: false)
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        locationSelectView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 30, enableInsets: false)
        currentLocationLabel.anchor(top: locationSelectView.topAnchor, left: locationSelectView.leftAnchor, bottom: locationSelectView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: locationSelectView.frame.width, height: 0, enableInsets: false)
    }
    
    func createNavBar() {
        let navItem = UINavigationItem(title: "")
        navItem.titleView = self.customNavBarView
        self.navBar.setItems([navItem], animated: false)
    }
    
    private let navBar: UINavigationBar = {
        let barHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        let screenSize: CGRect = UIScreen.main.bounds
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: barHeight, width: screenSize.width, height: 44))
        navBar.isTranslucent = true
        navBar.barTintColor = .white
        navBar.shadowImage = UIImage()
        return navBar
    }()
    
    private let customNavBarView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let orderNavButton : UIButton = {
        let button = UIButton()
        button.setTitle("Order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular_Semibold", size: 17)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let deliverNavButton : UIButton = {
        let button = UIButton()
        button.setTitle("Deliver", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular_Normal", size: 17)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let locationSelectView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let currentLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Medium", size: 17)
        label.textAlignment = .center
        
        let attachment = NSTextAttachment()
        let image = UIImage(systemName: "chevron.down")
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "Gates-Dell Complex")
        myString.append(attachmentString)
        label.attributedText = myString
        
        return label
    }()
    
    func addCurrentLocationLabelGesture() {
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCurrentLocationLabel))
            currentLocationLabel.isUserInteractionEnabled = true
            currentLocationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func didTapCurrentLocationLabel() {
        let selectLocationVC = SelectLocationViewController()
        self.present(selectLocationVC, animated: true)
    }
    
    
}
