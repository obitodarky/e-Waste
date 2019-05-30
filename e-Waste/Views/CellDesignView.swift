//
//  CellDesignView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 30/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

@IBDesignable
class CellDesignView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black

    
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.shadowColor = shadowColor?.cgColor
    }

}
