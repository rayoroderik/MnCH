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
    var gambarBayi = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textFieldPlaceHolder.isEnabled = false
        
        babyAddressTF.text = "Alamat"
        babyAddressTF.textColor = .lightGray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pickBabyImage.isUserInteractionEnabled = true
    pickBabyImage.addGestureRecognizer(tapGestureRecognizer)
        pickImage.delegate = self
        babyAddressTF.delegate = self
        // Do any additional setup after loading the view.
        
        let rightButton = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(self.addBabyNew))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.title = "Tambah Bayi"
    }
    
    @objc func addBabyNew(){
        if self.babyNameTF.text == nil || self.babyAddressTF == nil || self.jenisKelaminTF.text == nil || self.momNameTF.text == nil || self.momPhoneTF.text == nil || self.hariLahirTF.text == nil || self.bulanLahirTF.text == nil || self.tahunLahirTF.text == nil {
            let alert = UIAlertController(title: "Gagal", message: "Mohon isi semua kotak terlebih dahulu", preferredStyle: .alert)
            let okaction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okaction)
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
            testUploadImage()
        }
    }
    
    @IBAction func addBaby(_ sender: Any) {
//        if self.babyNameTF.text == nil || self.babyAddressTF == nil || self.jenisKelaminTF.text == nil || self.momNameTF.text == nil || self.momPhoneTF.text == nil || self.hariLahirTF.text == nil || self.bulanLahirTF.text == nil || self.tahunLahirTF.text == nil {
//            let alert = UIAlertController(title: "Gagal", message: "Mohon isi semua kotak terlebih dahulu", preferredStyle: .alert)
//            let okaction = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(okaction)
//            self.present(alert, animated: true, completion: nil)
//
//        }
//        else {
//            testUploadImage()
//        }
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Alamat"
            textView.textColor = .lightGray
        }
    }
    
        func testUploadImage(){
            let uploadImg = pickBabyImage.image
            let data = UIImageJPEGRepresentation(uploadImg!, 0.1)
            let tempRef = FirebaseReferences.storageRef.child("test/\(self.babyNameTF.text!).jpeg")

            let _ = tempRef.putData(data!, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("ERROR - \(error?.localizedDescription)")
                    return
                }
                print("success upload to storage")
                // You can also access to download URL after upload.
                tempRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    print("halo")
                    self.gambarBayi = downloadURL.absoluteString
                    
                    self.addNewBaby()
                }
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
        tempBaby["babyPhoto"] = gambarBayi
        
        GlobalKader.kader.kaderBabies.append(babyID)
        
        FirebaseReferences.databaseRef.child("kaders/\(GlobalKader.kader.kaderArea)/\(GlobalKader.kader.kaderID)/kaderBabies/\(babyID)").setValue("")
        FirebaseReferences.databaseRef.child("babies/\(babyID)").setValue(tempBaby)
        
        print("baby added")
    }
    
}
