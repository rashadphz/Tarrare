//
//  LocationUILabel.swift
//  Tarrare
//
//  Created by Rashad Philizaire on 7/11/22.
//

import Foundation
import UIKit

@IBDesignable
open class LocationUILabel: UILabel {
    
    func setup() {
        self.font = UIFont(name: "Inter-Regular_Medium", size: 17)
        self.textAlignment = .center
        self.textColor = .black
        
        self.setText(text: "")
    }
    
    func setText(text: String) {
        let attachment = NSTextAttachment()
        let image = UIImage(systemName: "chevron.down")
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: text)
        myString.append(attachmentString)
        self.attributedText = myString
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
