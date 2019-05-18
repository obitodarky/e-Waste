//
//  FeedbackView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 18/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class FeedbackView: UIViewController {

    
    @IBOutlet var feedbackMessage: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        feedbackMessage.layer.borderColor = myColor.cgColor
        
    }
    
    @IBAction func submitFeedback(_ sender: Any) {
    }
    

}
