//
//  ButtonsDesign.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 30/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class ButtonsDesign: UIButton {

    override func layoutSubviews() {
        layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.cornerRadius = 1
    }

}
