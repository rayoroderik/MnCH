//
//  BabyModel.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation


class BabyModel {
    var babyName: String
    var babyAddress: String
    var dobString: String
    var gender: String
    var momName: String
    var momPhone: String
    var babyCheck: [CheckModel] = []
    var babyID: String
    
    
    init(babyName: String, babyAddress: String, dobString: String, gender: String, momName: String, momPhone: String, babyID: String) {
        self.babyName = babyName
        self.babyAddress = babyAddress
        self.dobString = dobString
        self.gender = gender
        self.momName = momName
        self.momPhone = momPhone
        
        self.babyID = babyID
    }
}
