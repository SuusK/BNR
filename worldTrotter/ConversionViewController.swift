//
//  ConversionViewController.swift
//  worldTrotter
//
//  Created by Susan Kamies on 30/09/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    //MARK: Properties
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    //MARK: number formatter
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour > 7 && hour <= 18 {
            self.view.backgroundColor = UIColor.white
        }
        else {
            self.view.backgroundColor = UIColor.lightGray
        }
    }
    
    func updateCelsiusLabel(){
        if  let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeperator = string.range(of: decimalSeparator)
        
        if (existingTextHasDecimalSeperator != nil && replacementTextHasDecimalSeperator != nil) || string.rangeOfCharacter(from: NSCharacterSet.letters) != nil {
            return false
        }
        else {
            return true
        }
    }
    
    //MARK: Actions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    @IBAction func fahrenheitFieldEditingChanged(_ textfield: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
    
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    
}
