//
//  kaderSignUpViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class kaderSignUpViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var areaTF: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    //untuk pickerview
    var dataArea = ["Pedongkelan", "Kali Baru", "Cilincing", "Marunda", "Rusunawa Albo", "Tanah Merah"]
    var pickerArea = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addressTV.layer.cornerRadius = 5
        self.addressTV.layer.borderColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        self.addressTV.layer.borderWidth = 0.5
        
        addPickerArea()
    
        // Do any additional setup after loading the view.
    }
    
//    func testUploadImage(){
//        let data = UIImageJPEGRepresentation(#imageLiteral(resourceName: "hello"), 0.1)
//        let tempRef = FirebaseReferences.storageRef.child("test/hello.jpeg")
//
//        let _ = tempRef.putData(data!, metadata: nil) { (metadata, error) in
//            if error != nil{
//                print("ERROR - \(error?.localizedDescription)")
//                return
//            }
//            print("success upload to storage")
//            // You can also access to download URL after upload.
//            tempRef.downloadURL { (url, error) in
//                guard let downloadURL = url else {
//                    // Uh-oh, an error occurred!
//                    return
//                }
//
//                print(downloadURL)
//            }
//        }
//    }
    
//    var tempArray: [String] = []{
//        didSet{
//            print(tempArray)
//        }
//    }

//    func tampilin(){
//        FirebaseReferences.databaseRef.child("kaders").observeSingleEvent(of: .value) { (snap) in
//            let tempPlaces = snap.value as! [String:Any]
//
//            for (key, _) in tempPlaces{
//                let tempKaders = tempPlaces[key] as! [String:Any]
//
//                for (key, _) in tempKaders{
//                    let tempSingleKader = tempKaders[key] as! [String:Any]
//
//                    self.tempArray.append(tempSingleKader["kaderPhone"] as! String)
//
//                }
//
//            }
//        }
//    }
    

    @IBAction func daftarButtonClicked(_ sender: Any) {
        
        if (self.nameTextField.text == "" || self.addressTV.text == "" || self.phoneTextField.text == "" || self.areaTF.text == "" || self.passwordTextField.text == "" || self.confirmPasswordTextField.text == ""){
            
            let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Mohon isi semua field!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if (self.passwordTextField.text != self.confirmPasswordTextField.text){
            let alert = UIAlertController(title: "Pendaftaran Gagal", message: "Kata sandi tidak sesuai!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseReferences.databaseRef.observeSingleEvent(of: .value) { (snap) in
            if (snap.hasChildren() == false){
                // belom ada yg kedaftar
                self.register()
            }
            else{
                // udh ada yg daftar
                FirebaseReferences.databaseRef.child("kaders").observeSingleEvent(of: .value, with: { (snap) in
                    let tempPlaces = snap.value as! [String:Any]
                    
                    // ambil list of kaders dari 1 place
                    for (key, _) in tempPlaces{
                        let tempKaders = tempPlaces[key] as! [String:Any]
                        
                        // ambil single kader dari list of kaders
                        for (key, _) in tempKaders{
                            let tempSingleKader = tempKaders[key] as! [String:Any]
                            
                            let kaderPhone: String = tempSingleKader["kaderPhone"] as! String
                            
                            if (kaderPhone == self.phoneTextField.text){
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
                    }
                    
                    // aman
                    self.register()
                    
                })
            }
        }
    }
    
    func register(){
        
        let uniqueID = UUID().uuidString
        
        var tempKader: [String:Any] = [:]
        
        let hashedPassword = SHA1.hexString(from: self.passwordTextField.text!)
        
        tempKader["kaderName"] = self.nameTextField.text
        tempKader["kaderPhone"] = self.phoneTextField.text
        tempKader["kaderAddress"] = self.addressTV.text
        tempKader["kaderArea"] = self.areaTF.text
        tempKader["kaderBabies"] = ""
        tempKader["password"] = hashedPassword
        
        
        
        FirebaseReferences.databaseRef.child("kaders/\(self.areaTF.text!)/\(uniqueID)").setValue(tempKader)
        
        let alert = UIAlertController(title: "Pendaftaran Berhasil", message: "Anda telah mendaftar di ____!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            
            GlobalKader.loginState = true
            GlobalKader.kader = KaderModel(kaderName: self.nameTextField.text!, kaderPhone: self.phoneTextField.text!, kaderAddress: self.addressTV.text!, kaderArea: self.areaTF.text!, kaderBabies: [], kaderID: uniqueID)
            
            return
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        print("registered")
    }
    

}



extension kaderSignUpViewController: UIPickerViewDataSource {
    
    
    
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
            self.areaTF.text = dataArea[row]
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
        areaTF.inputView = pickerArea
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick))
        //toolbar.setItems([doneButton], animated: true)
        toolbar.items = [flexible, doneButton]
        
        areaTF.inputView = pickerArea
        areaTF.inputAccessoryView = toolbar
        
        
    }
    
    @objc func doneClick(){
        self.view.endEditing(true)
    }
    
    
    
}
