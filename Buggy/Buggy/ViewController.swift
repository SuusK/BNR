//
//  ViewController.swift
//  Buggy
//
//  Created by Susan Kamies on 17/12/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        //        print("Called buttonTapped(_:)")
        print("Method: \(#function) in fil: \(#file) line: \(#line) called/")
        
        badmethod()
    }
    
    func badmethod() {
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        // Go one step too far emptying the array (notice the range change):
        for _ in 0..<10 {
            array.removeObject(at: 0)
        }

    }
    
    //    @IBAction func switchToggled(_ sender: UISwitch) {
    //        print("Called buttonTapped(_:)")
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

