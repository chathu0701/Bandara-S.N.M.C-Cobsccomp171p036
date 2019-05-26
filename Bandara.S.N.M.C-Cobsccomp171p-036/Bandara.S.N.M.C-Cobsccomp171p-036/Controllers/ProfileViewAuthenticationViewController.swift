//
//  ProfileViewAuthenticationViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/26/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewAuthenticationViewController: UIViewController {
    
    let IDTouch = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func touchIdLoginAction(){
        IDTouch.authenticateUser(){ [weak self] message in
            if let message = message {
                let alertView = UIAlertController(title: "Authentication Error", message: message, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                    print("Try again")
                })
                
                alertView.addAction(okAction)
                self!.present(alertView, animated: true)
            }else{
                AppTempData.userData = Auth.auth().addStateDidChangeListener{(auth, user) in
                    if user == nil{
                        //self!.performSegue(withIdentifier: "ShowLogin", sender: nil)
                        
                        
                    }else{
                        
                        self!.performSegue(withIdentifier: "authPath", sender: nil)
                    }
                    
                }
                
            }
            
        }
    }
    
    @IBAction func ViewProf(_ sender: Any) {
        touchIdLoginAction()
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
