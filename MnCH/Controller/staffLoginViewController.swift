//
//  staffLoginViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class staffLoginViewController: UIViewController {
    @IBOutlet weak var staffPhone: UITextField!
    @IBOutlet weak var staffPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signInClick(_ sender: Any) {
        FirebaseReferences.databaseRef.child("staffs").observeSingleEvent(of: .value, with: { (snap) in
            let staffIDs = snap.value as! [String:Any]
            
            // ambil list of staffs
            for (key, _) in staffIDs{
                let tempSingleStaff = staffIDs[key] as! [String:Any]
                let staffPass: String = tempSingleStaff["staffPass"] as! String
                if (staffPass == self.phoneTextField.text){
                    // udah ada yg pernah pake phonenya
                    print("udah ada")
                    
                    let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Nomor telfon sudah pernah terdaftar!", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                        return
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            // aman
            self.register()
        })
        self.performSegue(withIdentifier: "staffLoginTostaffMain", sender: nil)
    }
    @IBAction func moveToKaderLogin(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginTomain", sender: nil)
    }
    @IBAction func signUpClick(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginToStaffSignUp", sender: nil)
    }
}
