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
    
    var kader: KaderModel!
    var listBabies = [BabyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailKaderTableView.delegate = self
        detailKaderTableView.dataSource = self
        
        detailKaderTableView.rowHeight = UITableViewAutomaticDimension
        
        lblKaderName.text = kader.kaderName
        lblKaderPhone.text = kader.kaderPhone
        imgKader.layer.cornerRadius = 50
        imgKader.clipsToBounds = true
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "Profil Kader"
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listBabies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.detailKaderTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! detailKaderTableViewCell
        cell.lblBabyName.text = self.listBabies[indexPath.row].babyName
        cell.imgBaby.image = self.listBabies[indexPath.row].babyPhoto
//        cell.lblBabyAge.text = self.listBabies[indexPath.row].
        
        cell.selectionStyle = .none
        return cell
    }
    
    func getData(){
        self.listBabies.removeAll()
        
        for babyID in self.kader.kaderBabies{
            FirebaseReferences.databaseRef.child("babies/\(babyID)").observeSingleEvent(of: .value) { (snap) in
                let tempSingleBaby = snap.value as! [String:Any]
                
                var tempBabyCheck: [String] = []
                if let tempBabyCheckDict: [String:String] = tempSingleBaby["babyCheck"] as? [String:String]{
                    for (checkID, _) in tempBabyCheckDict{
                        tempBabyCheck.append(checkID)
                    }
                }
                
                let url = URL(string: tempSingleBaby["babyPhoto"] as! String)
                let data = try? Data(contentsOf: url!)
                
                if let imageData = data{
                    let image = UIImage(data: imageData)
                    
                    self.listBabies.append(BabyModel(babyName: tempSingleBaby["babyName"] as! String, babyAddress: tempSingleBaby["babyAddress"] as! String, dobString: tempSingleBaby["dobString"] as! String, gender: tempSingleBaby["gender"] as! String, momName: tempSingleBaby["momName"] as! String, momPhone: tempSingleBaby["momPhone"] as! String, babyPhoto: image!, babyID: babyID, babyCheck: tempBabyCheck))
                    
                    self.detailKaderTableView.reloadData()
                }
                
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView , didSelectRowAt: IndexPath){
        self.performSegue(withIdentifier: "goToChildProfile", sender: nil)
    }
    
    
    
    
}
