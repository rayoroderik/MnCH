//
//  BabyModel.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation


class BabyModel {
    var name: String
    var dob: Date
    var dobString: String
    var gender: String
    var momName: String
    var momPhone: String
    
    init(name: String, dob: Date, dobString: String, gender: String, momName: String, momPhone: String) {
        self.name = name
        self.dob = dob
        self.dobString = dobString
        self.gender = gender
        self.momName = momName
        self.momPhone = momPhone
    }
}
