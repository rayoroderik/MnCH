//
//  addHistoryViewController.swift
//  MnCH
//
//  Created by Anisa Budiarthati on 04/09/18.
//  Copyright © 2018 Rayo Roderik. All rights reserved.
//

import UIKit

class addHistoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var babyID: String = ""
    var imageUpload: UIImage!
    var tempUrlImage:String = ""
    
    @IBOutlet weak var beratBadanTF: UITextField!
    @IBOutlet weak var tinggiBadanTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    @IBOutlet weak var imagePicked: UIImageView!
    let imagePicker = UIImagePickerController()
    
    func tampilan() {
        self.descTV.text = ""
        self.descTV.layer.cornerRadius = 5
        self.descTV.layer.borderWidth = 0.5
        self.descTV.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descTV.text = "Keterangan mengenai penampilan anak"
        descTV.textColor = .lightGray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imagePicked.isUserInteractionEnabled = true
        imagePicked.addGestureRecognizer(tapGestureRecognizer)
        
        descTV.delegate = self
        imagePicker.delegate = self
        tampilan()
        let rightButton = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(self.updateHistoryNew))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.title = "Tambah Data"
    }
    
    @IBAction func imagePickerClicked(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
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
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Keterangan mengenai penampilan anak"
            textView.textColor = .lightGray
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleAspectFit
            imagePicked.image = pickedImage
            self.imageUpload = imagePicked.image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateHistoryNew(){
        
        if self.beratBadanTF.text == "" || self.tinggiBadanTF.text == "" || self.descTV.text == "" {
            let alert = UIAlertController(title: "Gagal menambahkan data", message: "Mohon isi semua field!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        else if self.imagePicked.image == UIImage(named: "") {
            let alert = UIAlertController(title: "Gagal menambahkan data", message: "Mohon ambil foto bayi terbaru!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                return
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        else {
            self.testUploadImage()
            
        }

    }
    @IBAction func updateHistoryChildAction(_ sender: Any) {
        
        
        
        
        
        
        
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
        
        
        var tempBabiesCheck: [String:Any] = [:]
        
        let checkID = UUID().uuidString
        tempBabiesCheck["dateString"] = dateString
        tempBabiesCheck["weight"] = tempBeratBadan
        tempBabiesCheck["height"] = tempTinggiBadan
        tempBabiesCheck["notes"] = tempKeterangan
        tempBabiesCheck["babyPic"] = self.tempUrlImage
        
        
        FirebaseReferences.databaseRef.child("babies/testBabyID/babyCheck/\(checkID)").setValue("")
        FirebaseReferences.databaseRef.child("babyCheck/\(checkID)").setValue(tempBabiesCheck)
        
        let alert = UIAlertController(title: "Sukses", message: "Data telah berhasil di Input!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            return
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        return
        
        print("addHistoryBaby")
    }
    
    func testUploadImage(){
        let data = UIImageJPEGRepresentation(self.imageUpload, 0.1)

        let tempRef = FirebaseReferences.storageRef.child("ImageCheck/babyID-dateString.jpeg")

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

                print(downloadURL)
                self.tempUrlImage = downloadURL.absoluteString
                self.register()
            }
        }
    }

}
