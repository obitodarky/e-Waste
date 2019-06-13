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
    
    @IBOutlet var gradientView: UIViewX!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var incorrectLogin: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUp: UIButton!
    var colorArrayIndex = -1
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    
    @IBAction func showPassword(_ sender: Any) {
        if password.isSecureTextEntry {
            password.isSecureTextEntry = false
        } else{
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
        colorArray.append((color1: #colorLiteral(red: 0.5033842325, green: 0.8740338683, blue: 0.6319764256, alpha: 0.8470588235), color2: #colorLiteral(red: 0.3411764801, green: 0.8529547339, blue: 0.4490480466, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3411764801, green: 0.8529547339, blue: 0.4490480466, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), color2: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), color2: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), color2: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        animateBackgroundColor()
    }
    func animateBackgroundColor() {
        if colorArrayIndex == colorArray.count - 1 {
            colorArrayIndex = 0
        } else {
            colorArrayIndex += 1
        }
        UIView.transition(with: gradientView, duration: 2, options: [.transitionCrossDissolve], animations: {
            self.gradientView.firstColor = self.colorArray[self.colorArrayIndex].color1
            self.gradientView.secondColor = self.colorArray[self.colorArrayIndex].color2
        }) { (sucess) in
            self.animateBackgroundColor()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    func wrongLogIn() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: incorrectLogin.center.x - 10, y: incorrectLogin.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: incorrectLogin.center.x + 10, y: incorrectLogin.center.y))
        incorrectLogin.layer.add(animation, forKey: "position")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func logInPressed(_ sender: Any) {
       UIApplication.shared.beginIgnoringInteractionEvents()
        if(password.text != ""){
            SVProgressHUD.show(withStatus: "Logging in")
        }
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if(error != nil){
                SVProgressHUD.dismiss()
                self.incorrectLogin.text = "Incorrect Email or Password"
                self.wrongLogIn()
            } else {
                UserDefaults.standard.setValue(self.email.text, forKey: "email")
                UserDefaults.standard.setValue(self.password.text, forKey: "password")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "logIn", sender: self)
            }
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}


