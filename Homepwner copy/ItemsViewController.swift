//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Susan Kamies on 19/12/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController{
    
    var itemStore: ItemStore!
    var section_1 = [Item]()
    var section_2 = [Item]()
    var sections = [[Item]]()
    let section = ["Meer dan $50", "Overig"]
    
    
    //MARK: view-laad-functies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFit
        tableView.backgroundView = imageView
        
        
        //Get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        for item in itemStore.allItems {
            if item.valueInDollars >= 50 {
                section_1.append(item)
            }
            else {
                section_2.append(item)
            }
        }
        sections.append(section_1)
        sections.append(section_2)
        
    }
    
    //MARK: functies voor UITableViewCell
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            if section == 1 {
                return sections[section].count + 1}
            else {
                return sections[section].count}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Haal een nieuwe of gerecyclde cel op
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        //Set de text van de cel gelijk aan de omschrijving van het item op de nth index
        //waar n = rij deze cel te zien zal zijn in de tableview.
        if indexPath.section == 1 && indexPath.row == sections[indexPath.section].count {
            cell.textLabel?.text = "No more items"
            cell.detailTextLabel?.text = ""
        }
        else {
            let item = sections[indexPath.section][indexPath.row]
            cell.textLabel?.text = item.name
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == sections[indexPath.section].count {
            return 44
            
        }
        else {
            return 60
        }
    }
    
    
}
