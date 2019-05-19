//
//  studentViewViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/20/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Kingfisher

class studentViewViewController: UIViewController {

    @IBOutlet weak var profImg: UIImageView!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var fbURL: UILabel!
    
    var studentData : Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgURL = URL(string: studentData.profUrl)
        profImg.kf.setImage(with: imgURL)
        
        fName.text = studentData.firstName
        lName.text = studentData.lastName
        city.text = studentData.city
        phone.text = String(studentData.tel!)
        fbURL.text = studentData.fbProfile
        
        self.profImg.layer.cornerRadius = self.profImg.bounds.height / 2
        // Do any additional setup after loading the view.
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
