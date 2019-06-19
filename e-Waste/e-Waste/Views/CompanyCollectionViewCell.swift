
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
    var bankDetails: String!
    
}
