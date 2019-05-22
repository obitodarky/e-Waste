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

        // Do any additional setup after loading the view.
    }
    @IBAction func organizationSubmitPressed(_ sender: Any) {
    }
    
}
