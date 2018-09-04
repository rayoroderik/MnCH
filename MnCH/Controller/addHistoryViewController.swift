//
//  addHistoryViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class addHistoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var babyID: String = ""
    
    
    @IBOutlet weak var beratBadanTF: UITextField!
    @IBOutlet weak var tinggiBadanTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    @IBOutlet weak var imagePicked: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date)
        print(dateString)
    }
    
    @IBAction func imagePickerClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleAspectFit
            imagePicked.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateHistoryChildAction(_ sender: Any) {
        
        self.register()
        
//        FirebaseReferences.databaseRef.observeSingleEvent(of: .value) { (snap) in
//            if snap.hasChildren() == false {
//                self.register()
//            }
//            else {
//                FirebaseReferences.databaseRef.child("babies").observeSingleEvent(of: .value, with: { (snap) in
//                    let tempBabies = snap.value as! [String:Any]
//
//                    // ambil list of kaders dari 1 place
//                    for (key, _) in tempBabies{
//                        let tempSingleBabies = tempBabies[key] as! [String:Any]
//                        let babyCheck: [String:String] = tempSingleBabies["babyCheck"] as! [String:String]
//
//                        // ambil single kader dari list of kaders
//                        for (key, _) in babyCheck{
//                            let tempSingleBabyCheck = babyCheck[key] as! [String:Any]
//
//                            let babyCheckID: String = tempSingleBabyCheck["babyCheckID"] as! String
//
//                            if
//
//
//
//                        }
//                    }
//                    self.register()
//                })
//            }
//        }
    }
    
    
    func register(){
        
        //getDate
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        
        let tempBeratBadan = self.beratBadanTF.text
        let tempTinggiBadan = self.tinggiBadanTF.text
        let tempKeterangan = self.descTV.text
        let babyCheckID = UUID().uuidString
        
        var tempBabiesCheck: [String:Any] = [:]
        
        tempBabiesCheck["weight"] = tempBeratBadan
        tempBabiesCheck["height"] = tempTinggiBadan
        tempBabiesCheck["notes"] = tempKeterangan
        tempBabiesCheck["date"] = dateString
        
        FirebaseReferences.databaseRef.child("babies/testBabyID/babyCheck/\(babyCheckID)").setValue("")
        FirebaseReferences.databaseRef.child("babyCheck/\(babyCheckID)").setValue(tempBabiesCheck)
        
        print("addHistoryBaby")
    }

}
