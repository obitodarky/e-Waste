//
//  FeedbackView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 18/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit

class FeedbackView: UIViewController {

    
    @IBOutlet var feedbackSent: UILabel!
    @IBOutlet var feedbackMessage: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackSent.text = ""
        feedbackMessage.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        feedbackMessage.layer.borderWidth = 1.0;
        feedbackMessage.layer.cornerRadius = 5.0;
        
    }
    
    @IBAction func submitFeedback(_ sender: Any) {
        if(feedbackMessage.text != ""){
            feedbackSent.text = "✅Feedback sent successfuly!"
        } else {
            feedbackSent.text = "Please write something"
        }
    }
    
}
