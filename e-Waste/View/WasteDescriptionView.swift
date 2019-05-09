//
//  WasteDescriptionView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 31/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class WasteDescriptionView: UIViewController {

    
    @IBOutlet var wastePicture: UIImageView!
    @IBOutlet var wasteName: UILabel!
    @IBOutlet var wasteDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            wasteName.text = wasteArray[final_index]
            wasteDescription.text = wasteArray[final_index] + " is an organic waste."
            wastePicture.image = UIImage(imageLiteralResourceName: "vegetable")
    }
    

}
