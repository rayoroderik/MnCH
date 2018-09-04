//
//  FirebaseReference.swift
//  MnCH
//
//  Created by Steven Muliamin on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import Foundation
import Firebase


struct FirebaseReferences {
    static let databaseRef: DatabaseReference = Database.database().reference()
}
