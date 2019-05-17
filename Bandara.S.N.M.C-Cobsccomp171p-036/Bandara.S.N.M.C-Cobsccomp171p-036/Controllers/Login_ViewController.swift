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


class LoginViewController: UIViewController {
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var forgotpassword: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()

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
