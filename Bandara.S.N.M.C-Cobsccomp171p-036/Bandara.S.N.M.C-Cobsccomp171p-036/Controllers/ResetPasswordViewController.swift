//
//  ResetPasswordViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/19/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var Cancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Reset.layer.cornerRadius = self.Reset.bounds.height / 4
        self.Cancel.layer.cornerRadius = self.Cancel.bounds.height / 4

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Reset(_ sender: Any) {
        
        let email = self.Email.text!
       
        
        if email != "" {print("Enter Email")}
            Auth.auth().sendPasswordReset(withEmail: email) { error in
            // handle error when reset password
                if error != nil {
                    print(error?.localizedDescription)
                    return
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
