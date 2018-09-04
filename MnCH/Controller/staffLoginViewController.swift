//
//  staffLoginViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class staffLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signInClick(_ sender: Any) {
        self.performSegue(withIdentifier: "staffLoginTostaffMain", sender: nil)
    }
    @IBAction func moveToKaderLogin(_ sender: Any) {
        performSegue(withIdentifier: "staffLoginTomain", sender: nil)
    }
    
}
