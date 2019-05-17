//
//  ViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/17/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Handle the Authentication
    override func viewWillAppear(_ animated: Bool) {
        AppTempData.userData = Auth.auth().addStateDidChangeListener {(auth, user) in 
            
            if user == nil {
                // If the user didn't login
                self.performSegue(withIdentifier: "Login", sender: nil)
            
            }
            
            else {
                //If the user has been loged
                self.performSegue(withIdentifier: "Home", sender: nil)
            
            }
    }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(AppTempData.userData!)
    }
    

}
