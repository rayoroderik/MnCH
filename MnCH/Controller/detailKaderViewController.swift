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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! detailKaderTableViewCell
//        cell.lblNamaBayi.text = "Nama Anak \(indexPath.row)"
        
        return cell
    }
        
    func tableView(_ tableView: UITableView , didSelectRowAt: IndexPath){
        self.performSegue(withIdentifier: "goToChildProfile", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        detailKaderTableView.delegate = self
        detailKaderTableView.dataSource = self
    }
}
