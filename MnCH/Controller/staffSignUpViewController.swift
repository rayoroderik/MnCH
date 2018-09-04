//
//  staffSignUpViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class staffSignUpViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var verifyPassTextField: UITextField!
    @IBOutlet weak var areaPicker: UITextField!
    
    var dataArea = ["Pedongkelan", "Kali Baru", "Cilincing", "Marunda", "Rusunawa Albo", "Tanah Merah"]
    var pickerArea = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPickerArea()
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        if (self.nameTextField.text == "" || self.phoneTextField.text == "" || self.passTextField.text == "" || self.verifyPassTextField.text == "" ||
            self.areaPicker.text == ""){
            
            let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Mohon isi semua field!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if (self.passTextField.text != self.verifyPassTextField.text){
            let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Kata sandi tidak sesuai!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseReferences.databaseRef.child("staffs").observeSingleEvent(of: .value) { (snap) in
            if (snap.hasChildren() == false){
                // belom ada yg kedaftar
                self.register()
            }
            else{
                // udh ada yg daftar
                let staffIDs = snap.value as! [String:Any]
                
                // ambil list of staffs
                for (key, _) in staffIDs{
                    let tempSingleStaff = staffIDs[key] as! [String:Any]
                    let staffPhone: String = tempSingleStaff["staffPhone"] as! String
                    if (staffPhone == self.phoneTextField.text){
                        // udah ada yg pernah pake phonenya
                        print("udah ada")
                        
                        let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Nomor telfon sudah pernah terdaftar!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                            return
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                // aman
                self.register()
                
            }
        }
    }
    
    
    func register(){
        
        let uniqueID = UUID().uuidString
        
        var tempStaff: [String:Any] = [:]
        
        let hashedPassword = SHA1.hexString(from: self.passTextField.text!)!
        
        tempStaff["staffName"] = self.nameTextField.text
        tempStaff["staffPhone"] = self.phoneTextField.text
        tempStaff["staffArea"] = self.areaPicker.text
        tempStaff["staffPass"] = hashedPassword
        
        FirebaseReferences.databaseRef.child("staffs/\(uniqueID)").setValue(tempStaff)
        
        let alert = UIAlertController(title: "Pendaftaran Berhasil", message: "Anda telah mendaftar di ____!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default , handler: {(action) in
            self.performSegue(withIdentifier: "staffSignUpToStaffMain", sender: self)
            GlobalStaff.loginState = true
            GlobalStaff.staff = StaffModel(staffName: self.nameTextField.text!, staffPhone: self.phoneTextField.text!, staffArea: self.areaPicker.text!, staffID: uniqueID)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)

    }
}

extension staffSignUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //banyaknya data pickerview
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var toReturn: Int = 0
        if pickerView == pickerArea {
            toReturn = dataArea.count
        }
        
        return toReturn
    }
    
    //ketika pickerview dipilih
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerArea {
            self.areaPicker.text = dataArea[row]
        }
    }
    
    
    //title data pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var toReturn: String = ""
        if pickerView == pickerArea {
            toReturn = dataArea[row]
        }
        return toReturn
    }
    
    
    //func panggil pickerview area
    func addPickerArea (){
        pickerArea.delegate = self
        pickerArea.dataSource = self
        areaPicker.inputView = pickerArea
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick))
        //toolbar.setItems([doneButton], animated: true)
        toolbar.items = [flexible, doneButton]
        
        areaPicker.inputView = pickerArea
        areaPicker.inputAccessoryView = toolbar
        
        
    }
    
    @objc func doneClick(){
        self.view.endEditing(true)
    }
}
