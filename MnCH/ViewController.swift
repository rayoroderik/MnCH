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
  
    @IBAction func doSignInKader(_ sender: Any) {
        performSegue(withIdentifier: "mainTokaderMain", sender: nil)
    }
    
    @IBAction func doSignUpKader(_ sender: Any) {
        performSegue(withIdentifier: "mainTosignUp", sender: nil)
    }
    
    @IBAction func moveToStaffLogin(_ sender: Any) {
        performSegue(withIdentifier: "mainTostaffLogin", sender: nil)
    }
    
}

