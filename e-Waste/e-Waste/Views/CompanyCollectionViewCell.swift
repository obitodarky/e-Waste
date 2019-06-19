
//
//  CompanyCollectionViewCell.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 08/06/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    @IBOutlet var companyImage: UIImageView!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var companyNumber: UILabel!
    @IBOutlet var companyDescripttion: UILabel!
    @IBOutlet var donateButton: UIButton!
    @IBOutlet var companyAddress: UILabel!
    
    @IBAction func donateTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                
    }
}
