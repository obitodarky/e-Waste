//
//  ButtonsDesign.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 30/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonsDesign: UIButton {

    override func layoutSubviews() {
        
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 2
    }

}
