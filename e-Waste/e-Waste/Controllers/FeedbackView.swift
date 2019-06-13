//
//  FeedbackView.swift
//  e-VMSS
//
//  Created by Harsh Mehta on 18/05/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase
import StoreKit

class FeedbackView: UIViewController {
    
    @IBOutlet var feedbackSent: UILabel!
    @IBOutlet var feedbackMessage: UITextView!
    let date = Date()
    let calendar = Calendar.current
    var year: Int = 0
    var week: Int = 0
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackSent.text = ""
        feedbackMessage.layer.borderWidth = 2.0;
        feedbackMessage.layer.cornerRadius = 5.0;
        feedbackMessage.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 3.0).cgColor
    }
    
    @IBAction func submitFeedback(_ sender: Any) {
        if(feedbackMessage.text != ""){
            
            year = calendar.component(.year, from: date)
            week = calendar.component(.weekOfYear, from: date)
            hour = calendar.component(.hour, from: date)
            minutes = calendar.component(.minute, from: date)
            seconds = calendar.component(.second, from: date)
            ref = Database.database().reference()
            let reference = ref.child("Feedbacks")
            let users = Auth.auth().currentUser
            let uid = users!.uid
            reference.child(uid).child(String(year) + String(week) + String(hour) + String(minutes) + String(seconds)).setValue(feedbackMessage.text)
            feedbackSent.text = "✅Feedback sent successfuly!"
        } else { feedbackSent.text = "Please write something" }
    }
    
}
