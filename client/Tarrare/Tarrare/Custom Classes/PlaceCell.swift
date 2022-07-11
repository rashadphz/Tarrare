//
//  PlaceCell.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/11/22.
//

import Foundation
import UIKit

class PlaceCell: UITableViewCell {
    
    var place : Place? {
        didSet {
            nameLabel.text = place?.name
            addressLabel.text = place?.fullAddress
        }
    }
    
    private let locationImageView : UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .black
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Bold", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Semibold", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(named: "LightGray")
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        addSubview(locationImageView)
        addSubview(nameLabel)
        addSubview(addressLabel)
        
        locationImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 30, height: 0, enableInsets: false)
        
        nameLabel.anchor(top: topAnchor, left: locationImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 20, enableInsets: false)
        addressLabel.anchor(top: nameLabel.bottomAnchor, left: locationImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }
}
