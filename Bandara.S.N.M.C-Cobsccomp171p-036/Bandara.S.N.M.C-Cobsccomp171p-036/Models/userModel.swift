//
//  userModel.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/20/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

class User {
    
    //let firstName: String!
    let name: String!
    let age: Int!
    let bDate: String!
    let phone: Int!
    
    init (name: String, age: Int, bDate: String, phone:Int!){
        
        self.name = name
        self.age = age
        self.bDate = bDate
        self.phone = phone
    }
    
}


//init(fname: String, lName: String, tel: Int, profile: String, city: String!, pic: String){
//    self.firstName = fname
//    self.lastName = lName
//    self.tel = tel
//    self.fbProfile = profile
//    self.city = city
//    self.profUrl = pic
//}


//let imgURL = URL(string: userProf["profileImg"] as! String)
//self.profImage.kf.setImage(with: imgURL)
//self.name.text! = userProf["name"] as! String
//self.age.text! = String(userProf["age"] as! Int)
//self.bDate.text! = userProf["birthDate"] as! String
//self.phone.text! = String(userProf["phoneNumber"] as! Int)
