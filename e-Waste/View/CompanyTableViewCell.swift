//
//  CompanyTableViewCell.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 16/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet var company_image: UIImageView!
    @IBOutlet var company_name: UILabel!
    @IBOutlet var company_description: UILabel!
    @IBOutlet var company_phone_number: UILabel!
    @IBAction func donateToCompany(_ sender: Any) {
        //donate data transfer
    }
    
}
