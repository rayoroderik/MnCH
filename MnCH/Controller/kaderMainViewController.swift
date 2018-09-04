//
//  kaderMainViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class kaderMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var kaderMainTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! kaderMainTableViewCell
        cell.lblName.text = "Nama Anak \(indexPath.row)"
        cell.childImage.layer.cornerRadius = cell.childImage.frame.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//       if let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "goToChildProfile", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        kaderMainTableView.delegate = self
        kaderMainTableView.dataSource = self

    }

}
