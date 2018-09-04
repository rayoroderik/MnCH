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
    @IBOutlet weak var staffArea: UILabel!
    
    var listKader = [KaderModel]()
    var kaderName = ""
    var kaderPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        kaderTableView.delegate = self
        kaderTableView.dataSource = self
    }
    
    func getData(){
        let tempArea: String = GlobalStaff.staff.staffArea
        FirebaseReferences.databaseRef.child("kaders/\(tempArea)").observeSingleEvent(of: .value, with: { (snap) in
            if (snap.hasChildren() == false){
                // no kaders in that location
                return
            }
        
            let kaderIDs = snap.value as! [String:Any]
            self.staffArea.text = "\(tempArea)"
            
            for (key, _) in kaderIDs{
                let tempSingleKader = kaderIDs[key] as! [String:Any]
                
                var tempBabyArray: [String] = []
                if let tempBabyDict: [String:String] = tempSingleKader["kaderBabies"] as? [String:String]{
                    for (babyKey, _) in tempBabyDict{
                        tempBabyArray.append(babyKey)
                    }
                }
                
                self.listKader.append(KaderModel(kaderName: tempSingleKader["kaderName"] as! String, kaderPhone: tempSingleKader["kaderPhone"] as! String, kaderAddress: tempSingleKader["kaderAddress"] as! String, kaderArea: tempSingleKader["kaderArea"] as! String, kaderBabies: tempBabyArray, kaderID: key))
                self.kaderName = tempSingleKader["kaderName"] as! String
                self.kaderPhone = tempSingleKader["kaderPhone"] as! String
                self.kaderTableView.reloadData()
            }
        }
    )}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! staffMainTableViewCell
        cell.lblKader.text = kaderName
        cell.lblKaderHP.text = kaderPhone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToDetailKader", sender: nil)
    }

}
