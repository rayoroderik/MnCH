//
//  ViewController.swift
//  MnCH
//
//  Created by Rayo Roderik on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func kaderLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "goToKaderLogin", sender: nil)
    }
    
    @IBAction func staffLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "goToStaffLogin", sender: nil)
    }
    
}

