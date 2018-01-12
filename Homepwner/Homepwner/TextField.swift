//
//  TextField.swift
//  Homepwner
//
//  Created by Susan Kamies on 03/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        borderStyle = .bezel
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        borderStyle = .roundedRect
        return true 
    }
    
}
