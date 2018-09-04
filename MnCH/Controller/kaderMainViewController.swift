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
    
    var selectedIndex: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getData()
        kaderMainTableView.delegate = self
        kaderMainTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listBaby.removeAll()
        
        for babyID in GlobalKader.kader.kaderBabies{
            FirebaseReferences.databaseRef.child("babies/\(babyID)").observeSingleEvent(of: .value) { (snap) in
                let tempBaby = snap.value as! [String:Any]
                
                var tempBabyCheck: [String] = []
                if let tempBabyCheckDict: [String:String] = tempBaby["babyCheck"] as? [String:String]{
                    for (checkID, _) in tempBabyCheckDict{
                        tempBabyCheck.append(checkID)
                    }
                }
                
                let url = URL(string: tempBaby["babyPhoto"] as! String)
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data{
                    let image = UIImage(data: imageData)
                    self.listBaby.append(BabyModel(babyName: tempBaby["babyName"] as! String, babyAddress: tempBaby["babyAddress"] as! String, dobString: tempBaby["dobString"] as! String, gender: tempBaby["gender"] as! String, momName: tempBaby["momName"] as! String, momPhone: tempBaby["momPhone"] as! String, babyPhoto: image!, babyID: babyID, babyCheck: tempBabyCheck))
                    
                    self.kaderMainTableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChildProfile"{
            let destination = segue.destination as! childProfileViewController
            destination.currentBaby = self.listBaby[self.selectedIndex]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBaby.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.kaderMainTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! kaderMainTableViewCell
        cell.lblName.text = listBaby[indexPath.row].babyName
        cell.childImage.layer.cornerRadius = cell.childImage.frame.width / 2
        cell.childImage.image = listBaby[indexPath.row].babyPhoto
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
//       if let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "goToChildProfile", sender: self)
    }
    
    @IBAction func moveToAddChild(_ sender: Any) {
        performSegue(withIdentifier: "kaderMainToaddChild", sender: nil)
    }
    
}
