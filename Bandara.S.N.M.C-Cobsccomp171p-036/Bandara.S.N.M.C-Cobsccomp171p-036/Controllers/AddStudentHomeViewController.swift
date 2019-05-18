//
//  AddStudentHomeViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit

class AddStudentHomeViewController: UIViewController {

    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var AddProfileImage: UIButton!
    @IBOutlet weak var FName: UITextField!
    @IBOutlet weak var LName: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var FBURL: UITextField!
    @IBOutlet weak var Save: UIButton!
    @IBOutlet weak var Clear: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProfileImage.layer.cornerRadius = self.ProfileImage.bounds.height / 2
        self.Save.layer.cornerRadius = self.Save.bounds.height / 4
        self.Clear.layer.cornerRadius = self.Clear.bounds.height / 4
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddProfileImage(_ sender: Any) {
    }
    @IBAction func Save(_ sender: Any) {
    }
    @IBAction func Clear(_ sender: Any) {
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
