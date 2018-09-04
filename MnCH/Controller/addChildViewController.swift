//
//  addChildViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class addChildViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var pickBabyImage: UIImageView!
    @IBOutlet weak var babyNameTF: UITextField!
    @IBOutlet weak var jenisKelaminTF: UITextField!
    @IBOutlet weak var momNameTF: UITextField!
    @IBOutlet weak var momPhoneTF: UITextField!
    @IBOutlet weak var babyAddressTF: UITextView!
    @IBOutlet weak var hariLahirTF: UITextField!
    @IBOutlet weak var bulanLahirTF: UITextField!
    @IBOutlet weak var tahunLahirTF: UITextField!
    @IBOutlet weak var textFieldPlaceHolder: UITextField!
    let pickImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        babyAddressTF.text = "Alamat"
        babyAddressTF.textColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pickBabyImage.isUserInteractionEnabled = true
//        let addressTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addressTapped(addressTapGestureRecognizer:)))
//        babyAddressTF.addGestureRecognizer(addressTapGestureRecognizer)
//        pickBabyImage.addGestureRecognizer(tapGestureRecognizer)
        pickImage.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBaby(_ sender: Any) {
        addNewBaby()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickBabyImage.contentMode = .scaleAspectFit
            pickBabyImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addressTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedAddress = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        
        pickImage.allowsEditing = false
        pickImage.sourceType = .photoLibrary
        
        present(pickImage, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == .gray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Alamat"
            textView.textColor = .gray
        }
    }
    
    
    
    func addNewBaby(){
        let babyID = UUID().uuidString
        
        var tempBaby: [String:Any] = [:]
        var tglLahir = String(format: "%02d", Int(self.hariLahirTF.text!)!)
        var blnLahir = String(format: "%02d", Int(self.bulanLahirTF.text!)!)
        
        
        
        tempBaby["babyName"] = self.babyNameTF.text
        tempBaby["babyAddress"] = self.babyAddressTF.text
        tempBaby["dobString"] = "\(tglLahir)-\(blnLahir)-\(self.tahunLahirTF.text!)"
        tempBaby["gender"] = self.jenisKelaminTF.text
        tempBaby["momName"] = self.momNameTF.text
        tempBaby["momPhone"] = self.momPhoneTF.text
        tempBaby["babyCheck"] = ""
        
        
        FirebaseReferences.databaseRef.child("kaders/pedongkelan/testKaderID/kaderBaby/\(babyID)").setValue("")
        FirebaseReferences.databaseRef.child("babies/\(babyID)").setValue(tempBaby)
        
        print("baby added")
    }
    
}
