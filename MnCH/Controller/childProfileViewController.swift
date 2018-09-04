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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData.alpha = 1
        viewRedFlag.alpha = 0
        // Do any additional setup after loading the view.
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
