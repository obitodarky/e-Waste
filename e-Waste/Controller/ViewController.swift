//
//  ViewController.swift
//  ES presentation
//
//  Created by Harsh Mehta on 14/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController{


    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func wrongPassword(){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 15
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: password.center.x - 10, y: password.center.y) )
        animation.toValue = NSValue(cgPoint: CGPoint(x: password.center.x + 10, y: password.center.y))
        
        password.layer.add(animation, forKey: "position")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func loginUser(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if(error != nil){
                self.wrongPassword()
            } else {
                print("logged in")
            }
            
        }
    }
    
}

