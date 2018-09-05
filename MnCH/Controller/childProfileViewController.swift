//
//  childProfileViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class childProfileViewController: UIViewController {
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var viewRedFlag: UIView!
    
    @IBOutlet weak var imgBaby: UIImageView!
    @IBOutlet weak var lblBabyName: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnTelepon: UIButton!
    
    var currentBaby: BabyModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData.alpha = 1
        viewRedFlag.alpha = 0
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Profil Bayi"
        profilBayi()
    }

    
    func profilBayi(){
        self.lblBabyName.text = currentBaby.babyName
        self.lblDOB.text = currentBaby.dobString
        self.lblGender.text = currentBaby.gender
        self.lblAddress.text = currentBaby.babyAddress
        
        self.imgBaby.image = currentBaby.babyPhoto
        self.imgBaby.layer.cornerRadius = self.imgBaby.frame.width/2
        self.imgBaby.clipsToBounds = true
    }
    
    @IBAction func switchViewRescue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            viewData.alpha = 1
            viewRedFlag.alpha = 0
        }else if sender.selectedSegmentIndex == 1{
            viewData.alpha = 0
            viewRedFlag.alpha = 1
        }

    }
}
