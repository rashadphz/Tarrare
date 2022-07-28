//
//  DeliveryCell.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/13/22.
//

import Foundation
import UIKit

protocol DeliveryCellProtocol {
    func didTapChatIcon(tappedDelivery: Delivery)
}

class DeliveryCell : UITableViewCell {
    
    var delivery: Delivery? {
        didSet {
            guard let delivery = delivery else { return }
            deliveryPlaceNameLabel.text = delivery.deliveryBuilding.place.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white

    }
    
    private let containerStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 15
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
    
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }
}
