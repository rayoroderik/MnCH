//
//  staffMainViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class staffMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var kaderTableView: UITableView!
    
    var listKader = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        kaderTableView.delegate = self
        kaderTableView.dataSource = self
    }
    
    func getData(){
        FirebaseReferences.databaseRef.child("kaders/ped").observeSingleEvent(of: .value, with: { (snap) in
            let staffIDs = snap.value as! [String:Any]
            
            // ambil list of staffs
            for (key, _) in staffIDs{
                let tempSingleStaff = staffIDs[key] as! [String:Any]
                let staffPhone: String = tempSingleStaff["staffPhone"] as! String
//                if (staffPhone == self.phoneTextField.text){
//                    // udah ada yg pernah pake phonenya
//                    print("udah ada")
//
//                    let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Nomor telfon sudah pernah terdaftar!", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
//                        return
//                    }
//                    alert.addAction(okAction)
//                    self.present(alert, animated: true, completion: nil)
//                    return
//                }
            }
            // aman
            //
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! staffMainTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToDetailKader", sender: nil)
    }

}
