//
//  detailKaderViewController.swift
//  MnCH
//
//  Created by Claudya Tan on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class detailKaderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailKaderTableView: UITableView!
    @IBOutlet weak var imgKader: UIImageView!
    @IBOutlet weak var lblKaderName: UILabel!
    @IBOutlet weak var lblKaderPhone: UILabel!
    
    var currentUser = GlobalKader.loginState
    var kaderArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        detailKaderTableView.delegate = self
        detailKaderTableView.dataSource = self
        
        if currentUser == true {
            getSnap()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! detailKaderTableViewCell
        //        cell.lblNamaBayi.text = "Nama Anak \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView , didSelectRowAt: IndexPath){
        self.performSegue(withIdentifier: "goToChildProfile", sender: nil)
    }
    
    func getSnap(){
        FirebaseReferences.databaseRef.child("kaders").observeSingleEvent(of: .value) { (snap) in
        let tempPlaces = snap.value as! [String:Any]
        
        for (key, _) in tempPlaces{
            let tempKaders = tempPlaces[key] as! [String:Any]

            for (key, _) in tempKaders{
                let tempSingleKader = tempKaders[key] as! [String:Any]
//                self.kaderArray.append(tempSingleKader["kaderPhone"] as! String)
            }
        }
        }
    }
}
