//
//  ViewController.swift
//  TouchTracker
//
//  Created by Susan Kamies on 10/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    @IBOutlet var DrawView: DrawView!
    
    @IBAction func changeToRed(_ sender: UIButton) {
        print ("Button was pressed")
        
        self.DrawView.finishedLineColor = UIColor.yellow
        
        //DrawView.currentLineColor.setStroke()
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(_:)))
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        colorView.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DrawView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeUp(_ gestureRecognizer: UISwipeGestureRecognizer) {
        
        print("Swipiedieswipe")
        colorView.isHidden = false
    }
    
   
    
    


}

