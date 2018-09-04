//
//  settingsViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 05/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let rightButton = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(self.updateProfile))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.title = "Pengaturan"
    }
    
    @objc func askEdit(){
        let alert = UIAlertController(title: "Mengubah Profil", message: "Masukkan pengubahan", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]})) // hasil input user, mau ditaro kemana
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func updateProfile(){
        
    }

}
