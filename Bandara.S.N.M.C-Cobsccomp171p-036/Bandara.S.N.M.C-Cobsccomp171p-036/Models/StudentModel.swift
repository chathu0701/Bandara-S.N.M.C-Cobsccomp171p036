//
//  StudentModel.swift
//  Bandara.S.N.M.C-Cobsccomp171p-036
//
//  Created by MacBook on 5/18/19.
//  Copyright © 2019 MacBook. All rights reserved.
//

import Foundation

class Student{
    let firstName: String!
    let lastName: String!
    let tel: Int!
    let fbProfile: String!
    let city: String!
    let profUrl: String!
    
    init(fname: String, lName: String, tel: Int, profile: String, city: String!, pic: String){
        self.firstName = fname
        self.lastName = lName
        self.tel = tel
        self.fbProfile = profile
        self.city = city
        self.profUrl = pic
    }
}
