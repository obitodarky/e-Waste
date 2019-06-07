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
        if(password.isSecureTextEntry){
            password.isSecureTextEntry = false
        }else{
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
        colorArray.append((color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.8018642754, blue: 0.9686274529, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2392156869, green: 0.8018642754, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), color2: #colorLiteral(red: 0.4044704911, green: 0.8740338683, blue: 1, alpha: 0.8470588235)))
        colorArray.append((color1: #colorLiteral(red: 0.4044704911, green: 0.8740338683, blue: 1, alpha: 0.8470588235), color2: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), color2: #colorLiteral(red: 0.4164567924, green: 0.8740338683, blue: 0.4390986431, alpha: 0.8470588235)))
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        animateBackgroundColor()
    }
    
    func animateBackgroundColor(){
        //colorArrayIndex = colorArrayIndex == (colorArray.count -1) ? 0 : colorArrayIndex + 1
        if(colorArrayIndex == colorArray.count - 1){
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


