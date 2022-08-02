//
//  DeliverMatchViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 8/2/22.
//

import Foundation
import UIKit
import MapKit


class DeliverMatchViewController : UIViewController {
    var match : Match? {
        didSet {
            
            guard let delivery = match?.delivery else { return }
            guard let order = match?.order else { return }
            
            let deliveryBuildingPlace = delivery.deliveryBuilding.place
            
            self.deliveryBuildingNameLabel.text = deliveryBuildingPlace.name
            self.deliveryBuildingAddressLabel.text = deliveryBuildingPlace.fullAddress
            
            self.ordererNameLabel.text = order.user.firstName
            
            self.title = "Deliver from \(delivery.resturant.place.name)"
        }
    }
    
    var route : MKRoute? {
        didSet {
            guard let route = route else { return }
            
            mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveLabels)
            let rect = route.polyline.boundingMapRect
            let region = MKCoordinateRegion(rect)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRoute()
        self.addChatIconGesture()
        self.addDirectionsButtonGesture()
        
        self.view.backgroundColor = .white
        self.mapView.delegate = self
        
        view.addSubview(self.mapView)
        view.addSubview(self.containerView)
        
        self.containerView.addArrangedSubview(self.ordererNameLabel)
        self.containerView.addArrangedSubview(self.deliveryLocationStackView)
        self.containerView.addArrangedSubview(self.buttonsStackView)
        self.containerView.addSubview(self.completeDeliveryButton)
        
        self.deliveryLocationStackView.addArrangedSubview(self.deliveryBuildingNameLabel)
        self.deliveryLocationStackView.addArrangedSubview(self.deliveryBuildingAddressLabel)
        
        self.buttonsStackView.addArrangedSubview(self.directionsButton)
        self.buttonsStackView.addArrangedSubview(self.textButton)
        self.buttonsStackView.addArrangedSubview(self.spacer)
        
    }
    
    override func viewWillLayoutSubviews() {
        
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 25.0
        
        self.mapView.anchor(top: navigationController?.navigationBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: displayHeight/2, enableInsets: false)
        
        self.containerView.anchor(top: self.mapView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: 0, height: 0, enableInsets: false)
        
        self.completeDeliveryButton.anchor(top: nil, left: self.containerView.leftAnchor, bottom: view.bottomAnchor, right: self.containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 40, paddingRight: 0, width: displayWidth, height: 45, enableInsets: false)
    }
    
    // MARK: - Components
    
    private let mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    let containerView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let ordererNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.bold, size: 24)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveryLocationStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.spacing = 4
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let deliveryBuildingNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.semibold, size: 17)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveryBuildingAddressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 17)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "DarkGray")!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonsStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .fill
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stackview
    }()
    
    let directionsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .black
        button.setImage(UIImage(systemName: "map.fill"), for: .normal)
        button.setTitle("Directions", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.semibold, size: 18)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return button
    }()
    
    let textButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.setTitle("Text", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.semibold, size: 18)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return button
    }()
    
    let spacer : UIView = {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        spacer.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        return spacer
    }()
    
    let completeDeliveryButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .black
        button.setTitle("Complete delivery", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.semibold, size: 20)
        button.layer.cornerRadius = 45/2
        return button
    }()
    
    
    func fetchRoute() {
        guard let delivery = match?.delivery else { return }
        let restaurantPlace = delivery.resturant.place
        let deliveryBuildingPlace = delivery.deliveryBuilding.place
        
        MapManager.markMapFromPlaces(map: self.mapView, source: restaurantPlace, destination: deliveryBuildingPlace)
        
        MapManager.routeFromPlaces(source: restaurantPlace, destination: deliveryBuildingPlace, completion: {route in
            self.route = route
        })
    }
    
    
    //MARK: - Gestures/Actions
    @objc func didTapChatButton(_ sender: Any) {
        guard let ordererUser = match?.order.user else { return }
        
        let individualChatVC = IndividualChatViewController()
        individualChatVC.targetUser = ordererUser
        self.navigationController?.show(individualChatVC, sender: self)
    }
    
    func addChatIconGesture() {
        self.textButton.addTarget(self, action: #selector(didTapChatButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapDirectionsButton(_ sender: Any) {
        guard let delivery = match?.delivery else { return }
        
        MapManager.openDirectionsInMaps(source: delivery.resturant.place, destination: delivery.deliveryBuilding.place)
    }
    
    func addDirectionsButtonGesture() {
        self.directionsButton.addTarget(self, action: #selector(didTapDirectionsButton(_:)), for: .touchUpInside)
    }
}

extension DeliverMatchViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .black
        renderer.lineWidth = 4.0
        
        return renderer
    }
}


