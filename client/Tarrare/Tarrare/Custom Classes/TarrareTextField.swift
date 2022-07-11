//
//  TarrareTextField.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/7/22.
//

import Foundation
import UIKit

@IBDesignable
open class TarrareUITextField: UITextField {
    
    func setup() {
        self.font = UIFont(name: "Inter-Regular_Bold", size: 15)
        self.textColor = .black
        self.backgroundColor = .white
        self.layer.cornerRadius = 5;
        self.layer.borderColor = UIColor(named: "LightGray")?.cgColor
        self.layer.borderWidth = 2.0
        
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }
    
    func setImage(image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 30, height: 30))
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.addSubview(imageView)
        
        self.leftViewMode = UITextField.ViewMode.always
        self.leftViewMode = .always
        self.leftView = view
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
