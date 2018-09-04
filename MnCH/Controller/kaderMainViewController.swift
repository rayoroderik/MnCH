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
    var listBaby = [BabyModel]()
    var kaderName = ""
    var kaderPhone = ""
    var babyName = ""
    var babyAge = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBaby.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! kaderMainTableViewCell
        cell.lblName.text = babyName
        cell.childImage.layer.cornerRadius = cell.childImage.frame.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//       if let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "goToChildProfile", sender: self)
    }
    
    func getData(){
        print(GlobalKader.kader.kaderArea)
        print(GlobalKader.kader.kaderBabies)
        FirebaseReferences.databaseRef.child("kaders/\(GlobalKader.kader.kaderArea)/\(GlobalKader.kader.kaderID)/kaderBaby/\(GlobalKader.kader.kaderBabies)").observeSingleEvent(of: .value, with: { (snap) in
            if (snap.hasChildren() == false){
                // no baby
                return
            }
            
            let babyIDs = snap.value as! [String:Any]
            
            for (key, _) in babyIDs{
                let tempSingleBaby = babyIDs[key] as! [String:Any]
                
                
                self.listBaby.append(BabyModel(babyName: tempSingleBaby["babyName"] as! String, babyAddress: tempSingleBaby["babyAddress"] as! String, dobString: tempSingleBaby["dobString"] as! String, gender: tempSingleBaby["gender"] as! String, momName: tempSingleBaby["momName"] as! String, momPhone: tempSingleBaby["momPhone"] as! String, babyPhoto: tempSingleBaby["babyPhoto"] as! UIImage, babyID: key))
                
             
                self.babyName = tempSingleBaby["babyName"] as! String
                self.babyAge = tempSingleBaby["babyAge"] as! String
                self.kaderMainTableView.reloadData()
            }
        }
        
    )}

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        kaderMainTableView.delegate = self
        kaderMainTableView.dataSource = self
        
    }
    @IBAction func moveToAddChild(_ sender: Any) {
        performSegue(withIdentifier: "kaderMainToaddChild", sender: nil)
    }
    
}
