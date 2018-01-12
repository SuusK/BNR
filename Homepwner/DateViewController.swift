//
//  DateViewController.swift
//  Homepwner
//
//  Created by Susan Kamies on 03/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var item: Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        
        //Bewaar wijzigingen gemaakt aan het item
        item.dateCreated = datePicker.date
    }
}
