//
//  ItemStore.swift
//  Homepwner
//
//  Created by Susan Kamies on 19/12/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ItemStore {
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    var allItems = [Item]()
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        print("\(documentsDirectories.first!)")
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random:true)
        
        allItems.append(newItem)
        return newItem
        
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex:Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Haal de referentie op van het object dat wordt verplaatst zodat je kan herplaatsen
    
        let movedItem = allItems[fromIndex]
        
        // Verwijder item uit de array
        allItems.remove(at: fromIndex)
        
        //Voeg item toe in de array op de nieuwe locatie
        allItems.insert(movedItem, at: toIndex)
    }

    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
}
