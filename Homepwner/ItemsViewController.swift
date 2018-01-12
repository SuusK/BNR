//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Susan Kamies on 19/12/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //MARK: variabelen
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        // Maak een new item en voeg deze toe aan de store
        let newItem = itemStore.createItem()
        
        // Zoek uit waar dat item is binnen de array
        
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            //Voeg deze nieuwe rij toe in de tabel
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    //MARK: segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Als de getriggerede segue de "showItem" segue is...
        switch segue.identifier{
        case "showItem"?:
            //Zoek uit welke rij is aangeklikt
            if let row = tableView.indexPathForSelectedRow?.row{
                //Haal het juiste item op en stuur het door
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default: preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    
    //MARK: view-laad-functies
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    //MARK: functies voor UITableViewCell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Haal een nieuwe of gerecyclde cel op
        
        //Set de text van de cel gelijk aan de omschrijving van het item op de nth index
        //waar n = rij deze cel te zien zal zijn in de tableview.
        if itemStore.allItems.count == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = "No more items"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            let item = itemStore.allItems[indexPath.row]
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            
            if item.valueInDollars >= 50 {
                cell.valueLabel.textColor = UIColor.red
            }
            else {
                cell.valueLabel.textColor = UIColor.green
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Als de table view vraagt om een delete commando te committen
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Remove \(item.name)"
            let message = "Are your sure you want to remove this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
                // Verwijder het item uit de store
                self.itemStore.removeItem(item)
                
                //Verwijder de afbeelding uit de item store
                self.imageStore.deleteImage(forKey: item.itemKey)
                
                //Verwijder ook de rij van de table view met een animatie
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            //Laat de alert controller zien
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Update het model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row >= itemStore.allItems.count{
            return false
        }
        return true
    }
    
}
