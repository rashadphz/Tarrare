//
//  RestaurantCell.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/27/22.
//

import Foundation
import UIKit

class RestaurantCell : UITableViewCell {
    
    var restaurant: Resturant? {
        didSet {
            let place = restaurant?.place
            
            self.nameLabel.text = place?.name
            self.addressStreetLabel.text = place?.streetAddress
            self.addressLargerAreasLabel.text = "\(place?.city) \(place?.state), \(place?.zipcode)"
            // TODO (rashadphil) : retrieve restaurant logo from website
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
    }
    
    private let logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "takeoutbag.and.cup.and.straw")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Semibold", size: 15)
        label.textColor = .black
        return label
    }()
    
    private let addressView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let addressStreetLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Semibold", size: 12)
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    private let addressLargerAreasLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Regular_Semibold", size: 12)
        label.textColor = UIColor(named: "LightGray")
        return label
    }()
    
    private let arrowImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
    }
}
