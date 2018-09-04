//
//  StaffModel.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation

class StaffModel {
    var staffName: String
    var staffPhone: String
    var staffArea: String
    var staffID: String
    
    init(staffName: String, staffPhone: String, staffArea: String, staffID: String) {
        self.staffName = staffName
        self.staffPhone = staffPhone
        self.staffArea = staffArea
        
        self.staffID = staffID
    }
}
