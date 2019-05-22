//
//  RegisterOrganizationView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 21/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class RegisterOrganizationView: UIViewController {

    
    @IBOutlet var organizationNumber: UITextField!
    @IBOutlet var organizationImage: UIImageView!
    @IBOutlet var organizationName: UITextField!
    @IBOutlet var organizationDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        organizationDescription.text = ""
        organizationDescription.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        organizationDescription.layer.borderWidth = 1.0;
        organizationDescription.layer.cornerRadius = 5.0;

    }
    @IBAction func organizationSubmitPressed(_ sender: Any) {
    }
    
}
