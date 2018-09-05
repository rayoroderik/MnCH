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
    
    var listKader = [KaderModel]()
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        kaderTableView.delegate = self
        kaderTableView.dataSource = self
        let leftButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(self.doSettings))
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.title = GlobalStaff.staff.staffArea
    }
    
    @objc func doSettings(){
        
    }
    
    func getData(){
        let tempArea: String = GlobalStaff.staff.staffArea
        FirebaseReferences.databaseRef.child("kaders/\(tempArea)").observeSingleEvent(of: .value, with: { (snap) in
            if (snap.hasChildren() == false){
                // no kaders in that location
                return
            }
        
            let kaderIDs = snap.value as! [String:Any]
            
            for (key, _) in kaderIDs{
                let tempSingleKader = kaderIDs[key] as! [String:Any]
                
                var tempBabyArray: [String] = []
                if let tempBabyDict: [String:String] = tempSingleKader["kaderBabies"] as? [String:String]{
                    for (babyKey, _) in tempBabyDict{
                        tempBabyArray.append(babyKey)
                    }
                }
                
                self.listKader.append(KaderModel(kaderName: tempSingleKader["kaderName"] as! String, kaderPhone: tempSingleKader["kaderPhone"] as! String, kaderAddress: tempSingleKader["kaderAddress"] as! String, kaderArea: tempSingleKader["kaderArea"] as! String, kaderBabies: tempBabyArray, kaderID: key))
                print(tempBabyArray)
                
                self.kaderTableView.reloadData()
            }
        }
    )}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! staffMainTableViewCell
        cell.lblKader.text = listKader[indexPath.row].kaderName
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "goToDetailKader", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailKader"{
            let destination = segue.destination as! detailKaderViewController
            destination.kader = self.listKader[self.selectedIndex]
        }
    }
}
