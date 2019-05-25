//
//  WallpaperWindow.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 17/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import Foundation
import UIKit

class WallpaperWindow: UIWindow {
    
    var wallpaper: UIImage? = UIImage(named: "background") {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        if let wallpaper = wallpaper {
            wallpaper.draw(in: self.bounds);
        } else {
            super.draw(rect)
        }
    }
}
