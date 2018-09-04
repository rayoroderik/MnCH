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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
