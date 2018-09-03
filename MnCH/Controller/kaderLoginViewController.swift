//
//  kaderLoginViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class kaderLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signInClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToKaderMain", sender: nil)
    }
    
}
