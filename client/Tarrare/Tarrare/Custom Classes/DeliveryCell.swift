//
//  DeliveryCell.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/13/22.
//

import Foundation
import UIKit
import MapKit

protocol DeliveryCellProtocol {
    func didTapRequestButton(tappedDelivery: Delivery)
}

class DeliveryCell : UITableViewCell {
    
    var delivery: Delivery? {
        didSet {
            guard let delivery = delivery else { return }
            deliveryPlaceNameLabel.text = delivery.deliveryBuilding.place.name
            self.setDistanceInformation()
        }
    }
    var delegate : DeliveryCellProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.addRequestButtonGesture()
        
        contentView.addSubview(self.containerStackView)
        contentView.addSubview(self.requestButtonView)
        
        self.requestButtonView.addSubview(self.requestButton)
        
        self.containerStackView.addArrangedSubview(self.locationInfoStackView)
        self.containerStackView.addArrangedSubview(self.distanceInfoStackView)
        self.containerStackView.addHorizontalSeparator(color: .black)
        
        self.locationInfoStackView.addArrangedSubview(self.titleDeliveryLocationLabel)
        self.locationInfoStackView.addArrangedSubview(self.deliveryPlaceNameLabel)
        
        self.distanceInfoStackView.addArrangedSubview(self.titleRelativeDistanceLabel)
        self.distanceInfoStackView.addArrangedSubview(self.distanceView)
        
        self.distanceView.addArrangedSubview(self.distanceInMilesLabel)
        self.distanceView.addArrangedSubview(self.walkingWidget)
        self.distanceView.addArrangedSubview(self.spacer)
        
        self.containerStackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        self.requestButtonView.anchor(top: contentView.topAnchor, left: self.containerStackView.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: -20, width: 0, height: 0, enableInsets: false)
        self.requestButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 35, enableInsets: false)
        self.requestButton.centerXAnchor.constraint(equalTo: self.requestButtonView.centerXAnchor).isActive = true
        self.requestButton.centerYAnchor.constraint(equalTo: self.requestButtonView.centerYAnchor).isActive = true
    }
    
    private let containerStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 12
        return stackview
    }()
    
    private let locationInfoStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 3
        return stackview
    }()
    
    private let titleDeliveryLocationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 17)
        label.textColor = UIColor(named: "DarkGray")!
        label.text = "Delivery Location:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deliveryPlaceNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.semibold, size: 17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let distanceInfoStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 3
        return stackview
    }()
    
    private let titleRelativeDistanceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 17)
        label.textColor = UIColor(named: "DarkGray")!
        label.text = "You -> Delivery Location:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let distanceView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let distanceInMilesLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.FontDefaults.medium, size: 16)
        label.textColor = .black
        label.text = "0.0 miles"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let walkingWidget : WalkingWidget = {
        let widget = WalkingWidget()
        return widget
    }()
    
    private let spacer : UIView = {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        spacer.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        return spacer
    }()
    
    private let requestButtonView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let requestButton : UIButton = {
        let button = UIButton()
        button.setTitle("Request", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.medium, size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tintColor = .white
        return button
    }()
    
    func setDistanceInformation() {
        guard let userCurrentPlace = Place.userCurrent else { return }
        guard let deliveryBuilding = delivery?.deliveryBuilding else { return }
        
        if userCurrentPlace == deliveryBuilding.place {
            self.walkingWidget.walkingMinutes = -1
            return
        }
        
        MapManager.routeFromPlaces(source: userCurrentPlace, destination: deliveryBuilding.place, completion: {route in
            
            guard let route = route else { return }
            
            let distanceInMeters = Measurement(value: route.distance, unit: UnitLength.meters)
            let distanceInMiles = distanceInMeters.converted(to: UnitLength.miles)
            let distanceString = String(MeasurementFormatter().string(from: distanceInMiles).prefix(4))
            
            self.distanceInMilesLabel.text = "\(distanceString) miles"
            self.walkingWidget.walkingMinutes = Int(route.expectedTravelTime / 60.0)
        })
    }
    
    
    // MARK: - Actions/Gestures
    
    @objc func didTapRequestButton(_ sender: UIButton) {
        if let delivery = delivery {
            self.delegate.didTapRequestButton(tappedDelivery: delivery)
        }
    }
    
    func addRequestButtonGesture() {
        self.requestButton.addTarget(self, action: #selector(didTapRequestButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }
}

class WalkingWidget : UIButton {
    public var walkingMinutes: Int? {
        didSet {
            guard let time = walkingMinutes else { return }
            if time == -1 {
                self.backgroundColor = UIColor(hex: "#28B711")!
                self.setTitle("Match", for: .normal)
                let buttonImage = UIImage(systemName: "checkmark")
                self.setImage(buttonImage, for: .normal)
                return
            }
            
            if time >= 10 {
                self.backgroundColor = UIColor(hex: "#EB3901")!
            } else if time >= 6 {
                self.backgroundColor = UIColor(hex: "#D36906")!
            } else if time != 0 {
                self.backgroundColor = UIColor(hex: "#FBBC05")!
            }
            self.setTitle("\(time) min", for: .normal)
            let buttonImage = UIImage(systemName: "figure.walk.circle")
            self.setImage(buttonImage, for: .normal)
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
        let button = self
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.FontDefaults.medium, size: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 15)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
}
