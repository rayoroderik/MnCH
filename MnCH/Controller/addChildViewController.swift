//
//  addChildViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 03/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class addChildViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickBabyImage: UIImageView!
    @IBOutlet weak var babyNameTF: UITextField!
    @IBOutlet weak var jenisKelaminTF: UITextField!
    @IBOutlet weak var momNameTF: UITextField!
    @IBOutlet weak var momPhoneTF: UITextField!
    @IBOutlet weak var babyAddressTF: UITextView!
    @IBOutlet weak var hariLahirTF: UITextField!
    @IBOutlet weak var bulanLahirTF: UITextField!
    @IBOutlet weak var tahunLahirTF: UITextField!
    let pickImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        pickBabyImage.isUserInteractionEnabled = true
        pickBabyImage.addGestureRecognizer(tapGestureRecognizer)
        pickImage.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickBabyImage.contentMode = .scaleAspectFit
            pickBabyImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Your action
        
        pickImage.allowsEditing = false
        pickImage.sourceType = .photoLibrary
        
        present(pickImage, animated: true, completion: nil)
    }
    
    var kaderModel : KaderModel?
    
    func addNewBaby(){
        let babyID = UUID().uuidString
        
        var tempBaby: [String:Any] = [:]
        
        
        
        tempBaby["babyName"] = self.babyNameTF
        tempBaby["babyAddress"] = self.babyAddressTF.text
        tempBaby["dobString"] = "\(self.hariLahirTF.text)/\(self.bulanLahirTF.text)/\(self.tahunLahirTF.text)"
        tempBaby["gender"] = self.jenisKelaminTF.text
        tempBaby["momName"] = self.momNameTF.text
        tempBaby["momPhone"] = self.momPhoneTF.text
        
        
        
        FirebaseReferences.databaseRef.child("kaders/pedongkelan/\(hehe)/bayi/\(babyID)").setValue(tempBaby)
        
        print("registered")
    }
    
}
