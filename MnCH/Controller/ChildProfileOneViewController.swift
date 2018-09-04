//
//  ChildProfileOneViewController.swift
//  MnCH
//
//  Created by Marco Febriano Ramadhani on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class ChildProfileOneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addHistoryClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "goToAddHistory", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
