//
//  DeliverScreenViewController.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/29/22.
//

import Foundation
import UIKit

class DeliverScreenViewController: UIViewController {
    public var editingLocationComponent : LocationComponentView?
    var delivery : Delivery? {
        didSet {
            Delivery.userCurrent = delivery;
            
            guard let delivery = delivery else { return }

            restaurantComponentView.place = delivery.resturant.place
            deliveryLocationComponentView.place = delivery.deliveryBuilding.place
            
            if (delivery.orderStatus == "placed") {
                toggleDeliveryStatusButton.backgroundColor = UIColor(named: "DarkGreen")
                toggleDeliveryStatusButton.setTitle("Delivering", for: .normal)
            } else {
                toggleDeliveryStatusButton.backgroundColor = UIColor(named: "DarkRed")
                toggleDeliveryStatusButton.setTitle("Not Delivering", for: .normal)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(self.containerStackView)
        
        self.containerStackView.addArrangedSubview(self.restuarantInfoStackView)
        self.containerStackView.addArrangedSubview(self.deliveryBuildingInfoStackView)
        self.containerStackView.addArrangedSubview(self.toggleDeliveryStatusButton)
        
        self.restuarantInfoStackView.addArrangedSubview(self.currentRestaurantLabel)
        self.restuarantInfoStackView.addArrangedSubview(self.restaurantComponentView)
        
        self.deliveryBuildingInfoStackView.addArrangedSubview(self.deliveryLocationLabel)
        self.deliveryBuildingInfoStackView.addArrangedSubview(self.deliveryLocationComponentView)
        
        self.restaurantComponentView.parentVC = self
        self.deliveryLocationComponentView.parentVC = self
        
        self.addDeliveryButtonGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let sidePadding = 25.0
        
        self.containerStackView.anchor(top: self.navigationController?.navigationBar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: sidePadding, paddingBottom: 0, paddingRight: sidePadding, width: 0, height: 0, enableInsets: false)
    }
    
    let containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let restuarantInfoStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 5
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let currentRestaurantLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 23)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Current Restaurant"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let restaurantComponentView : LocationComponentView = {
        let view = LocationComponentView()
        return view
    }()
    
    let deliveryBuildingInfoStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 5
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let deliveryLocationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 23)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Delivery Location"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveryLocationComponentView : LocationComponentView = {
        let view = LocationComponentView()
        return view
    }()
    
    let toggleDeliveryStatusButton : UIButton = {
        let button = UIButton()
        button.setTitle("Not Delivering", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.bold, size: 22)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func createDelivery() {
        guard let currentUser = User.getCurrent() else { return }
        guard let restaurant = restaurantComponentView.place else { return }
        guard let deliveryBuilding = deliveryLocationComponentView.place else { return }
        
        Delivery.createDelivery(userId: currentUser.id, orderStatus: "placed", resturantPlaceId: restaurant.id, deliveryBuildingPlaceId: deliveryBuilding.id, completion: {createdDelivery in
            self.delivery = createdDelivery
        })
    }
    
    func cancelDelivery() {
        guard let delivery = delivery else { return }

        Delivery.cancelDelivery(deliveryId: delivery.id, completion: {cancelledDelivery in
            self.delivery = cancelledDelivery
        })
    }
    
    @objc func didTapToggleDeliveryButton(_ sender: Any) {
        if self.delivery == nil || self.delivery!.orderStatus == "cancelled" {
            self.createDelivery()
        } else {
            self.cancelDelivery()
        }
    }
    
    func addDeliveryButtonGesture() {
        self.toggleDeliveryStatusButton.addTarget(self, action: #selector(didTapToggleDeliveryButton(_:)), for: .touchUpInside)
    }
    
}

extension DeliverScreenViewController : SelectLocationViewDelegate {
    func sendSelectedPlace(place: Place) {
        guard let editingLocationComponent = self.editingLocationComponent else { return }
        editingLocationComponent.place = place
    }
}

class LocationComponentView : UIView {
    public var parentVC : DeliverScreenViewController?
    public var place : Place? {
        didSet {
            guard let place = place else { return }

            locationNameLabel.text = place.name
            locationStreetAddressLabel.text = place.streetAddress
            locationLargerAddressLabel.text = "\(place.city) \(place.state), \(place.zipcode)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
      }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor(named: "LightGray")!.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 15
        
        self.addSubview(locationStackView)
        self.addSubview(editButtonView)
        
        self.locationStackView.addArrangedSubview(locationNameLabel)
        self.locationStackView.addArrangedSubview(locationStreetAddressLabel)
        self.locationStackView.addArrangedSubview(locationLargerAddressLabel)
        
        self.editButtonView.addSubview(editButton)
        
        self.setupLayout()
        self.addEditButtonGesture()
    }
    
    private func setupLayout() {
        self.locationStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0, enableInsets: false)
        
        self.editButtonView.anchor(top: topAnchor, left: self.locationStackView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 100, height: 0, enableInsets: false)
        self.editButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 70, height: 25, enableInsets: false)
        self.editButton.centerXAnchor.constraint(equalTo: self.editButtonView.centerXAnchor).isActive = true
        self.editButton.centerYAnchor.constraint(equalTo: self.editButtonView.centerYAnchor).isActive = true
    }
    
    let locationStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 3
        stackview.alignment = .top
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    let locationNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.semibold, size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationStreetAddressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 15)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "DarkGray")!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLargerAddressLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 15)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "DarkGray")!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editButtonView : UIView = {
        let view = UIView()
        return view
    }()
    
    let editButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.medium, size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonImage = UIImage(systemName: "pencil")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()
    
    // MARK: - LocationComponent Gestures/Actions
    
    @objc func didTapEditButton(_ sender: Any) {
        guard let parentVC = parentVC else { return }
        
        let selectLocationVC = SelectLocationViewController()
        selectLocationVC.delegate = parentVC
        
        parentVC.editingLocationComponent = self
        parentVC.present(selectLocationVC, animated: true)
    }
    
    func addEditButtonGesture() {
        editButton.addTarget(self, action: #selector(didTapEditButton(_:)), for: .touchUpInside)
    }
}
