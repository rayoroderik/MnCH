//
//  ViewController.swift
//  MnCH
//
//  Created by Rayo Roderik on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func checkKaderLogin(){
        if (self.passwordTextField.text == "" || self.passwordTextField.text == ""){
            let alert = UIAlertController(title: "Gagal", message: "Mohon isi semua field!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let tempHashedPassword = SHA1.hexString(from: self.passwordTextField.text!)!
            FirebaseReferences.databaseRef.child("kaders").observeSingleEvent(of: .value) { (snap) in
                if (snap.hasChildren() == false){
                    // phone not registered
                    self.makeAlert(title: "Gagal", message: "Nomor tidak terdaftar!")
                    return
                }
                else{
                    let tempPlaces = snap.value as! [String:Any]
                    
                    for (key, _) in tempPlaces{
                        let tempSinglePlace = tempPlaces[key] as! [String:Any]
                        for (placeKey, _) in tempSinglePlace{
                            let tempSingleKader = tempSinglePlace[placeKey] as! [String:Any]
                            
                            if ((tempSingleKader["kaderPhone"] as! String) == self.phoneTextField.text){
                                if (tempSingleKader["password"] as! String == tempHashedPassword){
                                    // success login
                                    let alert = UIAlertController(title: "Berhasil", message: "Anda telah login!", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                        self.successLogin()
                                    })
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    var tempBabyArray: [String] = []
                                    
                                    if let tempBabyDict: [String:String] = tempSingleKader["kaderBabies"] as? [String:String]{
                                        for (babyKey, _) in tempBabyDict{
                                            tempBabyArray.append(babyKey)
                                        }
                                    }
                                    
                                    GlobalKader.loginState = true
                                    GlobalKader.kader = KaderModel(kaderName: tempSingleKader["kaderName"] as! String, kaderPhone: tempSingleKader["kaderPhone"] as! String, kaderAddress: tempSingleKader["kaderAddress"] as! String, kaderArea: tempSingleKader["kaderArea"] as! String, kaderBabies: tempBabyArray, kaderID: placeKey)
                                    return
                                }
                                else{
                                    // failed login - wrong password
                                    self.makeAlert(title: "Gagal", message: "Kata sandi salah!")

                                }
                            }
                        }
                    }
                    // phone not registered
                    self.makeAlert(title: "Gagal", message: "Nomor tidak terdaftar!")
                    return
                }
            }
        }
    }
    
    func successLogin(){
        performSegue(withIdentifier: "mainTokaderMain", sender: nil)
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doSignInKader(_ sender: Any) {
        self.checkKaderLogin()
    }
    
    @IBAction func doSignUpKader(_ sender: Any) {
        performSegue(withIdentifier: "mainTosignUp", sender: nil)
    }
    
    @IBAction func moveToStaffLogin(_ sender: Any) {
        performSegue(withIdentifier: "mainTostaffLogin", sender: nil)
    }
    
}

