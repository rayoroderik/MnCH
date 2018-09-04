//
//  CheckModel.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation
import UIKit

// model for each checking of a baby's current data


class CheckModel{
    var weight: Float
    var height: Float
    var notes: String
    var babyPic: UIImage!
    
    init(weight: Float, height: Float, notes: String) {
        self.weight = weight
        self.height = height
        self.notes = notes
    }
    
    func setPic(babyPic: UIImage){
        self.babyPic = babyPic
    }
}
