//
//  UserProfileViewViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/20/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher

class UserProfileViewViewController: UIViewController {

    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var bDate: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    let uname: String = ""
    let uage: Int = 0
    let ubDate: String = ""
    let uphone: Int = 0
    
    var ref: DatabaseReference!
    
    //ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getViewUserData()
        // Do any additional setup after loading the view.
    }
    
    
    func getViewUserData(){
        
        let userID = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("users/user/").child(userID!).observeSingleEvent(of: .value, with: {(DataSnapshot) in
            
            if let userProf = DataSnapshot.value as? [String : AnyObject]{
                
                
                let imgURL = URL(string: userProf["profileImg"] as! String)
                self.profImage.kf.setImage(with: imgURL)
                self.name.text! = userProf["name"] as! String
                self.age.text! = String(userProf["age"] as! Int)
                self.bDate.text! = userProf["birthDate"] as! String
                self.phone.text! = String(userProf["phoneNumber"] as! Int)
                
                
                print("")
            }
        }, withCancel: nil)
        
        
        //ref.child("users/user/\(userID)").observeSingleEvent(of: .value, with: { (snapshot) in
        
      //   ref.child("users").child((userID)!).child("user").observeSingleEvent(of: .value, with: { (snapshot) in
            
           // print(snapshot)
            
            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User(username: username)
//
            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
