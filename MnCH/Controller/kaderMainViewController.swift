//
//  kaderMainViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit
import Firebase

class kaderMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var kaderMainTableView: UITableView!
    var totalBaby = 0
    var babi = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("sekarang \(totalBaby)")
        return totalBaby
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! kaderMainTableViewCell
        cell.lblName.text = "Nama Anak \(babi)"
        cell.childImage.layer.cornerRadius = cell.childImage.frame.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//       if let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "goToChildProfile", sender: self)
    }
    
    func getData(){
        FirebaseReferences.databaseRef.child("kaders/pedongkelan/testKaderID/kaderBaby").observeSingleEvent(of: .value, with: { (snap) in
            let babyID = snap.value as! [String:Any]
            for (key, _) in babyID{
                let tempSingleBabies = babyID[key] as! String
                self.babi.append(tempSingleBabies)
            }
            // ambil list of staffs
//            for (key, _) in allBabies{
//                let tempSingleStaff = staffIDs[key] as! [String:Any]
//                let staffPhone: String = tempSingleStaff["staffPhone"] as! String
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
            })
            // aman
            //
        
    }

    func getTotalBaby()
    {
        FirebaseReferences.databaseRef.child("kaders/pedongkelan/testKaderID/kaderBaby").observeSingleEvent(of: .value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                self.totalBaby = snapshots.count
                print(self.totalBaby)
                DispatchQueue.main.async(execute: {
                    self.kaderMainTableView.delegate = self
                    self.kaderMainTableView.dataSource = self
                    self.kaderMainTableView.reloadData()
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTotalBaby()
        getData()
        
    }
    @IBAction func moveToAddChild(_ sender: Any) {
        performSegue(withIdentifier: "kaderMainToaddChild", sender: nil)
    }
    
}
