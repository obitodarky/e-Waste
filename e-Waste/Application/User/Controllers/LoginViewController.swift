//
//  ViewController.swift
//  ES presentation
//
//  Created by Harsh Mehta on 14/03/19.
//  Copyright © 2019 Harsh Mehta. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate{


    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var incorrectLogin: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUp: UIButton!
    
    @IBAction func showPassword(_ sender: Any) {
        if(password.isSecureTextEntry){
            password.isSecureTextEntry = false
        } else {
            password.isSecureTextEntry = true
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        incorrectLogin.text = ""
        loginButton.layer.shadowOpacity = 0.15
        loginButton.layer.shadowRadius = 1
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 1
        
        signUp.layer.shadowOpacity = 0.15
        signUp.layer.shadowRadius = 1
        signUp.layer.shadowColor = UIColor.black.cgColor
        signUp.layer.cornerRadius = 1
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func wrongLogIn(){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: incorrectLogin.center.x - 10, y: incorrectLogin.center.y) )
        animation.toValue = NSValue(cgPoint: CGPoint(x: incorrectLogin.center.x + 10, y: incorrectLogin.center.y))
        
        incorrectLogin.layer.add(animation, forKey: "position")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        if(password.text != ""){
            SVProgressHUD.show(withStatus: "Logging in")
        }
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if(error != nil){
                SVProgressHUD.dismiss()
                self.incorrectLogin.text = "Incorrect Email or Password"
                self.wrongLogIn()
            }
            else {
                UserDefaults.standard.setValue(self.email.text, forKey: "email")
                UserDefaults.standard.setValue(self.password.text, forKey: "password")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "logIn", sender: self)
            }
        }
    }
}


