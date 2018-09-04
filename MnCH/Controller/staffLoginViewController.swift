//
//  staffLoginViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class staffLoginViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInClick(_ sender: Any) {
        FirebaseReferences.databaseRef.child("staffs").observe(.value) { (snap) in
            if (snap.hasChildren() == false){
                
                // phone not registered
                let alert = UIAlertController(title: "Masuk Gagal", message: "Nomor handphone tidak ada!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    return
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let tempStaffs = snap.value as! [String:Any]
            
            for (key, _) in tempStaffs{
                let tempSingleStaff = tempStaffs[key] as! [String:Any]
                let tempPhone = tempSingleStaff["staffPhone"] as! String
                
                if (tempPhone == self.phoneTextField.text!){
                    
                    // found
                    let tempPass = tempSingleStaff["staffPass"] as! String
                    let tempHashed = SHA1.hexString(from: self.passTextField.text!)!
                    
                    if(tempHashed == tempPass){
                        // correct
                        let staffName = tempSingleStaff["staffName"] as! String
                        let staffArea = tempSingleStaff["staffArea"] as! String
                        
                        self.performSegue(withIdentifier: "staffLoginTostaffMain", sender: nil)
                        GlobalStaff.loginState = true
                        GlobalStaff.staff = StaffModel(staffName: staffName, staffPhone: self.phoneTextField.text!, staffArea: staffArea, staffID: key)
                    }
                    else{
                        // wrong password
                        let alert = UIAlertController(title: "Masuk Gagal", message: "Kata sandi salah!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                            return
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
            }
            // phone not registered
            let alert = UIAlertController(title: "Masuk Gagal", message: "Nomor handphone tidak ada!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    @IBAction func moveToKaderLogin(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginTomain", sender: nil)
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginToStaffSignUp", sender: nil)
    }
}
