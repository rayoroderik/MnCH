//
//  BabyModel.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation
import UIKit


class BabyModel {
    var babyName: String
    var babyAddress: String
    var dobString: String
    var gender: String
    var momName: String
    var momPhone: String
    var babyCheck: [String] = []
    var babyPhoto: UIImage!
    var babyID: String
    
    
    init(babyName: String, babyAddress: String, dobString: String, gender: String, momName: String, momPhone: String, babyPhoto: UIImage, babyID: String, babyCheck: [String]) {
        self.babyName = babyName
        self.babyAddress = babyAddress
        self.dobString = dobString
        self.gender = gender
        self.momName = momName
        self.momPhone = momPhone
        self.babyPhoto = babyPhoto
        self.babyCheck = babyCheck
        
        self.babyID = babyID
    }
}
