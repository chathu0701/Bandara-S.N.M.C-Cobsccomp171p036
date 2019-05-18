//
//  LoginViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/17/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var forgotpassword: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var googlesignin: GIDSignInButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.Login.layer.cornerRadius = self.Login.bounds.height / 4
        self.createAccount.layer.cornerRadius = self.createAccount.bounds.height / 4
        self.googlesignin.layer.cornerRadius = self.googlesignin.bounds.height / 4
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: self.Email.text!,password: self.Password.text!)
        { [weak self] user, error in guard let strongSelf = self else { return }
            
            if error != nil{
                
                let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            
            } else{
                
                strongSelf.dismiss(animated: true, completion: nil)
            
            }
            
            // ...
        }
    }
    
    //In the app delegate, implement the GIDSignInDelegate protocol to handle the sign-in process by defining the following methods:
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                let alert = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                // ...
                return
            }
            // User is signed in
            // ...
            self.dismiss(animated: true, completion: nil)
            print(authResult!.user.email!)
        }
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    @IBAction func forgotpassword(_ sender: Any) {
    }
    
    @IBAction func createAccount(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
