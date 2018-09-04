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
