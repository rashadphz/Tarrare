//
//  NewOfferViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/20/22.
//

import Foundation
import UIKit
import MapKit

class NewOfferViewController : UIViewController {
    var match : Match? {
        didSet {
            
            deliveryBuildingInfoView.place = match?.delivery.deliveryBuilding.place
            resturantInfoView.place = match?.delivery.resturant.place
            
            resturantInfoView.placeImageView.image = UIImage(systemName: "mappin.circle.fill")
            deliveryBuildingInfoView.placeImageView.image = UIImage(systemName: "stop.circle")
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
        
        self.view.backgroundColor = .white
        title = "New Offer"
        self.mapView.delegate = self
        
        acceptButton.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(didTapDecline), for: .touchUpInside)
        
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(mapView)
        view.addSubview(newDeliveryView)
        
        newDeliveryView.addSubview(containerView)
        
        containerView.addSubview(newDeliveryLabel)
        containerView.addSubview(resturantInfoView)
        containerView.addSubview(deliveryBuildingInfoView)
        containerView.addSubview(acceptButton)
        containerView.addSubview(declineButton)
        
        let displayWidth = self.view.frame.width
        let displayHeight = self.view.frame.height
        
        let sidePadding = 30.0
        mapView.anchor(top: navigationController?.navigationBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: displayHeight/2.5, enableInsets: false)
        
        newDeliveryView.anchor(top: mapView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: displayHeight/2, enableInsets: false)
        containerView.anchor(top: newDeliveryView.topAnchor, left: newDeliveryView.leftAnchor, bottom: newDeliveryView.bottomAnchor, right: newDeliveryView.rightAnchor, paddingTop: 20, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: displayWidth, height: displayHeight/2, enableInsets: false)
        newDeliveryLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        resturantInfoView.anchor(top: newDeliveryLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 100, enableInsets: false)
        deliveryBuildingInfoView.anchor(top: resturantInfoView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 100, enableInsets: false)
        
        acceptButton.anchor(top: deliveryBuildingInfoView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        declineButton.anchor(top: acceptButton.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: displayWidth, height: 50, enableInsets: false)
        
    }
    
    // MARK: - Components
    
    private let mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private let newDeliveryView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let newDeliveryLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.FontDefaults.semibold, size: 24)
        label.text = "New Delivery"
        return label
    }()
    
    private let resturantInfoView : LocationInfoView = {
        let view = LocationInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let deliveryBuildingInfoView : LocationInfoView = {
        let view = LocationInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let acceptButton : UIButton = {
        let button = UIButton()
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.bold, size: 21)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let declineButton : UIButton = {
        let button = UIButton()
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.bold, size: 21)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
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
    
    // MARK: - Gestures/Actions
    @objc func didTapAccept() {
        guard let match = self.match else {
            return
        }
        Match.acceptMatch(matchId: match.id, completion: {acceptedMatch in
            guard let acceptedMatch = acceptedMatch else { return }
            
            let deliverMatchVC = DeliverMatchViewController()
            let navController = UINavigationController(rootViewController: deliverMatchVC)
            navController.modalPresentationStyle = .fullScreen
            deliverMatchVC.match = acceptedMatch
            
            let presentingVC = self.presentingViewController
            self.dismiss(animated: false, completion: {
                presentingVC?.present(navController, animated: true)
            })
        })
    }
    
    @objc func didTapDecline() {
        guard let match = self.match else {
            return
        }
        Match.declineMatch(matchId: match.id, completion: {_ in})
        self.dismiss(animated: true)
    }
    
}

class LocationInfoView : UIView {
    var place : Place? {
        didSet {
            guard let place = place else {
                return
            }
            
            placeNameLabel.text = place.name
            placeStreetAddressLabel.text = place.streetAddress
            placeStateCityLabel.text = "\(place.city), \(place.state) \(place.zipcode)"
        }
    }
    
    override func layoutSubviews() {
        self.addSubview(placeImageView)
        self.addSubview(placeNameLabel)
        
        self.addSubview(placeAddressView)
        placeAddressView.addSubview(placeStreetAddressLabel)
        placeAddressView.addSubview(placeStateCityLabel)
        
        placeImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 20, paddingRight: 8, width: 40, height: 40, enableInsets: false)
        placeNameLabel.anchor(top: topAnchor, left: placeImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0, enableInsets: false)
        
        placeAddressView.anchor(top: placeNameLabel.bottomAnchor, left: placeImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 20, paddingRight: 0, width:0, height: 0, enableInsets: false)
        placeStreetAddressLabel.anchor(top: placeAddressView.topAnchor, left: placeAddressView.leftAnchor, bottom: nil, right: placeAddressView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        placeStateCityLabel.anchor(top: placeStreetAddressLabel.bottomAnchor, left: placeAddressView.leftAnchor, bottom: placeAddressView.bottomAnchor, right: placeAddressView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    public let placeImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let placeNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let placeAddressView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let placeStreetAddressLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightGray")!
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let placeStateCityLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "LightGray")!
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
}

extension NewOfferViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .black
        renderer.lineWidth = 4.0
        
        return renderer
    }
}

