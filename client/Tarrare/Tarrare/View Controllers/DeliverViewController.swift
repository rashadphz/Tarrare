//
//  OrderViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/11/22.
//

import Foundation
import UIKit
import CoreLocation

class DeliverViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentResturant: Place?
    var deliveryLocation: Place?
    var tappedLocationLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            requestUserCurrentPlace()
        }
        
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.addSubview(resturantSelectStackView)
        containerView.addSubview(deliveryLocationSelectStackView)
        
        resturantSelectStackView.addArrangedSubview(myResturantLabel)
        resturantSelectStackView.addArrangedSubview(resturantLocationLabel)
        
        deliveryLocationSelectStackView.addArrangedSubview(myDeliveryLocationLabel)
        deliveryLocationSelectStackView.addArrangedSubview(deliveryLocationLabel)
        
        addResturantLabelGesture()
        addDeliveryLocationGesture()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        requestUserCurrentPlace()
    }
    
    override func viewWillLayoutSubviews() {
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 20.0
        
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight/2, enableInsets: false)
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        resturantSelectStackView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: containerView.frame.width, height: 30, enableInsets: false)
        myResturantLabel.anchor(top: resturantSelectStackView.topAnchor, left: resturantSelectStackView.leftAnchor, bottom: resturantSelectStackView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        resturantLocationLabel.anchor(top: resturantSelectStackView.topAnchor, left: myResturantLabel.rightAnchor, bottom: resturantSelectStackView.bottomAnchor, right: resturantSelectStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        deliveryLocationSelectStackView.anchor(top: resturantSelectStackView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: containerView.frame.width, height: 30, enableInsets: false)
        myDeliveryLocationLabel.anchor(top: deliveryLocationSelectStackView.topAnchor, left: deliveryLocationSelectStackView.leftAnchor, bottom: deliveryLocationSelectStackView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        deliveryLocationLabel.anchor(top: deliveryLocationSelectStackView.topAnchor, left: myDeliveryLocationLabel.rightAnchor, bottom: deliveryLocationSelectStackView.bottomAnchor, right: deliveryLocationSelectStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // User Resturant
    private let resturantSelectStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 3
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let myResturantLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Bold", size: 17)
        label.textColor = .black
        label.text = "My Resturant: "
        return label
    }()
    
    private let resturantLocationLabel: LocationUILabel = {
        let label = LocationUILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    // User Delivery Location
    private let deliveryLocationSelectStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 3
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let myDeliveryLocationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Bold", size: 17)
        label.textColor = .black
        label.text = "Delivery Location: "
        return label
    }()
    
    private let deliveryLocationLabel: LocationUILabel = {
        let label = LocationUILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        return label
    }()
    
    func setCurrentResturant(place: Place) {
        self.currentResturant = place
        self.resturantLocationLabel.setText(text: place.name)
    }
    
    func setCurrentDeliveryLocation(place: Place) {
        self.deliveryLocation = place
        self.deliveryLocationLabel.setText(text: place.name)
    }
        
    func requestUserCurrentPlace() {
        //COMMENTED OUT TO LIMIT API REQUESTS TEMPORARILY
        
        //        APIManager.shared().getCurrentPlace(completion: {(place) in
//            self.setCurrentPlace(place: place)
//        })
    }
    
    // GESTURES / ACTIONS
    
    func addResturantLabelGesture() {
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapResturantLabel))
        resturantLocationLabel.isUserInteractionEnabled = true
        resturantLocationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func didTapResturantLabel() {
        let selectLocationVC = SelectLocationViewController()
        tappedLocationLabel = resturantLocationLabel
        
        selectLocationVC.delegate = self
        self.present(selectLocationVC, animated: true)
    }
    
    func addDeliveryLocationGesture() {
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDeliveryLocationLabel))
        deliveryLocationLabel.isUserInteractionEnabled = true
        deliveryLocationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func didTapDeliveryLocationLabel() {
        let selectLocationVC = SelectLocationViewController()
        tappedLocationLabel = deliveryLocationLabel
        
        selectLocationVC.delegate = self
        self.present(selectLocationVC, animated: true)
    }
    
    
}

extension DeliverViewController : SelectLocationViewDelegate {
    func sendSelectedPlace(place: Place) {
        if (tappedLocationLabel == resturantLocationLabel) {
            setCurrentResturant(place: place)
        } else {
            setCurrentDeliveryLocation(place: place)
        }
    }
}

