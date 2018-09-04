//
//  KaderModel.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation

class KaderModel {
    var kaderName: String
    var kaderPhone: String
    var kaderAddress: String
    var kaderArea: String
    var kaderBabies: [String]
    
    init(kaderName: String, kaderPhone: String, kaderAddress: String, kaderArea: String, kaderBabies: [String]) {
        self.kaderName = kaderName
        self.kaderPhone = kaderPhone
        self.kaderAddress = kaderAddress
        self.kaderArea = kaderArea
        self.kaderBabies = kaderBabies
    }
}
