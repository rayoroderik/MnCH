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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("sekarang \(totalBaby)")
        return totalBaby
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! kaderMainTableViewCell
        cell.lblName.text = "Nama Anak \(indexPath.row)"
        cell.childImage.layer.cornerRadius = cell.childImage.frame.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//       if let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "goToChildProfile", sender: self)
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
        
    }
    @IBAction func moveToAddChild(_ sender: Any) {
        performSegue(withIdentifier: "kaderMainToaddChild", sender: nil)
    }
    
}
