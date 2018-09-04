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
        FirebaseReferences.databaseRef.child("staffs").observeSingleEvent(of: .value, with: { (snap) in
            let staffIDs = snap.value as! [String:Any]
            let hashedPassword = SHA1.hexString(from: self.passTextField.text!)
            
            // ambil semua nomor hp staff
            var allStaffPhone = [String]()
            for (key, _) in staffIDs{
                let tempSingleStaff = staffIDs[key] as! [String:Any]
                let staffPhone: String = tempSingleStaff["staffPhone"] as! String
                allStaffPhone.append(staffPhone)
                if allStaffPhone.contains(self.phoneTextField.text!){
                    for (key, _) in staffIDs{
                        let tempSingleStaff = staffIDs[key] as! [String:Any]
                        let staffPhone: String = tempSingleStaff["staffPhone"] as! String
                        let staffPass: String = tempSingleStaff["staffPass"] as! String
                        
                        
                        if (staffPhone == self.phoneTextField.text) && (staffPass == hashedPassword){
                            self.performSegue(withIdentifier: "staffLoginTostaffMain", sender: nil)
                        }else{
                            let alert = UIAlertController(title: "Masuk Gagal", message: "Kata sandi salah!", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                                return
                            }
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }else{
                    let alert = UIAlertController(title: "Masuk Gagal", message: "Nomor handphone tidak ada!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        return
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
        }
        })
    }
    
    @IBAction func moveToKaderLogin(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginTomain", sender: nil)
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginToStaffSignUp", sender: nil)
    }
}
