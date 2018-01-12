//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Susan Kamies on 28/12/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: Actions en outlets
    @IBAction func backgroudTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBOutlet var nameField: TextField!
    @IBOutlet var serialNumberField: TextField!
    @IBOutlet var valueField: TextField!
    @IBOutlet var dateLabel: TextField!
    @IBAction func changeDate(_ sender: UIButton) {
        
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        
        //Als het toestel een camera heeft, neem een foto; anders,
        //kies een foto vanuit het album
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        
        imagePicker.delegate = self
        
        // Plaats de image picker op het scherm
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBOutlet var removeImageOutlet: UIButton!
    @IBAction func removeImage(_ sender: UIButton) {
        print ("\(item.itemKey)")
        let key = item.itemKey
        imageStore.deleteImage(forKey: key)
        
        imageView.image = nil
    }
    
    //MARK: variabelen
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        
        //Bewaar wijzigingen gemaakt aan het item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        //Haal de item key op
        let key = item.itemKey
        
        //Als er een afbeelding hoort bij de key geef dan de afbeelding weer
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
        
        if imageToDisplay == nil {
            removeImageOutlet.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Als de getriggerede segue de "showItem" segue is...
        switch segue.identifier{
        case "showDate"?:
            //Zoek uit welke rij is aangeklikt
            let item = self.item
            let detailViewController = segue.destination as! DateViewController
            detailViewController.item = item
        default: preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    //MARK: Textfield delegate methodes
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Image Picker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        //Krijg gekozen afbeelding van de info dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //Bewaar de afbeelding in de ImageStore voor de item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        //Plaats de afbeelding op het scherm in de image view
        imageView.image = image
        
        removeImageOutlet.isHidden = false
        
        
        //Haal de image picker van het scherm
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
}
