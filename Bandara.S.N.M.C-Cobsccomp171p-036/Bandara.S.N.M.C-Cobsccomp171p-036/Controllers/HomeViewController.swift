//
//  HomeViewController.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/17/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher // get url path as a binary file n send when ask

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var HomeStudentTableView: UITableView!
    //define and create a reference to your database as follows
   var studentDataSet: [Student] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.cellRegister()
        self.getStudent()
        
        self.HomeStudentTableView.tableFooterView = UIView()
        
        HomeStudentTableView.delegate = self
        HomeStudentTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func cellRegister(){
        
        self.HomeStudentTableView.register(UINib(nibName: "HomeTableTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableTableViewCell")
        //register a cell for UITableView
        
        //self.HomeStudentTableView.register(nib)
        //let nib = UINib(nibName: "nameOfYourNibFile", bundle: nil) tableView.register(nib, forCellReuseIdentifier: "yourIdentifier")
    }
    
   /* func getStudentData(){
        
        //self.showActivity
       self.ref.child("StudentDB/Student").observeSingleEvent(of: .value, with: { (snapshot) in
            //get user data
            let data = snapshot.value as? NSDictionary
            
            //let studentlist = value
            
            print(data!)
            
            var newstudent: [Student] = []
            
            if snapshot.childrenCount > 0{
                
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    //get data
                    
                    let studentObject = student.value as?[String:AnyObject]
                    
                    let student = Student(fName: studentObject!["fName"] as! String, lName: studentObject!["lName"] as! String, city: studentObject!["city"] as! String, phoneNumber: studentObject!["phoneNumber"] as! Int, fbURL: studentObject!["fburL"] as! String, profileURL: studentObject!["profileURL"] as! String)
                    newstudent.append(student)
                }
            }
            
            self.studentDataSet = newstudent
            
            //print(self.studentDataSet[0].fName)
            
            self.HomeStudentTableView.reloadData()
            
            //hide Activity
            })
        {
            (error)in
            
            print(error.localizedDescription)
        }
        
    }*/
    
    
    func getStudent(){
        
        self.ref.child("StudentDB/Student").observeSingleEvent(of: .value, with: {
            (snapshot) in
            
            var newAyy: [Student] = []
            
            if snapshot.childrenCount > 0 {
                for std in snapshot.children.allObjects as! [DataSnapshot]{
                    let stdObject = std.value as? [String: AnyObject]
                    
                    let student = Student(fname: stdObject!["firstName"] as! String, lName: stdObject!["lastName"] as! String, tel: stdObject!["tel"] as! Int, profile: stdObject!["fbProfile"] as! String, city: stdObject!["city"] as! String, pic: stdObject!["profUrl"] as! String)
                    
                    newAyy.append(student)
                    
                    
                }
                
            }
            
            self.studentDataSet = newAyy
            
            self.HomeStudentTableView.reloadData()
            
        }){ (error) in
            print(error.localizedDescription)
            
            
        }
        
    }
    

    @IBAction func LogOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.navigationController?.dismiss(animated: true)
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.studentDataSet.count
        return self.studentDataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentPrototypeCell = tableView.dequeueReusableCell(withIdentifier: "studentPrototypeCell", for: indexPath) as! HomeTableViewCell
//
        let profImgURL = URL(string: self.studentDataSet[indexPath.row].profUrl)
        studentPrototypeCell.profileImage.kf.setImage(with:profImgURL)
        studentPrototypeCell.name.text = self.studentDataSet[indexPath.row].firstName + " " +
            self.studentDataSet[indexPath.row].lastName
        studentPrototypeCell.city.text = self.studentDataSet[indexPath.row].city
        //
//        return studentPrototypeCell
        
//             let profImgURL = URL(string: "")
//               studentPrototypeCell.ProfileImage.kf.setImage(with:profImgURL)
//               studentPrototypeCell.Name.text = ""
//               studentPrototypeCell.City.text = ""
        
        return studentPrototypeCell
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
