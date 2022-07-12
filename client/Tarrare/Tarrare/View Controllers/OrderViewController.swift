//
//  DeliverViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/11/22.
//

import Foundation
import UIKit
import CoreLocation

class OrderViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentPlace: Place?
    
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
        containerView.addSubview(locationSelectView)
        locationSelectView.addSubview(currentLocationLabel)
        addCurrentLocationLabelGesture()
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
        
        locationSelectView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: containerView.frame.width, height: 30, enableInsets: false)
        currentLocationLabel.anchor(top: locationSelectView.topAnchor, left: locationSelectView.leftAnchor, bottom: locationSelectView.bottomAnchor, right: locationSelectView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let locationSelectView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let currentLocationLabel: LocationUILabel = {
        let label = LocationUILabel()
        label.textAlignment = .center
        return label
    }()
    
    func setCurrentPlace(place: Place) {
        self.currentPlace = place
        self.currentLocationLabel.setText(text: place.name)
    }
        
    func requestUserCurrentPlace() {
        //COMMENTED OUT TO LIMIT API REQUESTS TEMPORARILY
        
        //        APIManager.shared().getCurrentPlace(completion: {(place) in
//            self.setCurrentPlace(place: place)
//        })
    }
    
    // GESTURES / ACTIONS
    
    func addCurrentLocationLabelGesture() {
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCurrentLocationLabel))
            currentLocationLabel.isUserInteractionEnabled = true
            currentLocationLabel.addGestureRecognizer(labelTapGesture)
    }
    
    @objc func didTapCurrentLocationLabel() {
        let selectLocationVC = SelectLocationViewController()
        selectLocationVC.delegate = self
        self.present(selectLocationVC, animated: true)
    }
    
    
}

extension OrderViewController : SelectLocationViewDelegate {
    func sendSelectedPlace(place: Place) {
        setCurrentPlace(place: place)
    }
}

