//
//  FeedbackView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 18/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase

class FeedbackView: UIViewController {

    
    @IBOutlet var feedbackSent: UILabel!
    @IBOutlet var feedbackMessage: UITextView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackSent.text = ""
        feedbackMessage.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        feedbackMessage.layer.borderWidth = 1.0;
        feedbackMessage.layer.cornerRadius = 5.0;
    }
    
    @IBAction func submitFeedback(_ sender: Any) {
        if(feedbackMessage.text != ""){
            ref = Database.database().reference()
            let reference = ref.child("Feedbacks")
            let users = Auth.auth().currentUser
            let uid = users!.uid
            reference.child(uid).setValue(feedbackMessage.text)
            
            feedbackSent.text = "✅Feedback sent successfuly!"
        } else {
            feedbackSent.text = "Please write something"
        }
    }
    
}
