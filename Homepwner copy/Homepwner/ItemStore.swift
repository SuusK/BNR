//
//  ItemStore.swift
//  Homepwner
//
//  Created by Susan Kamies on 19/12/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random:true)
        
        allItems.append(newItem)
        return newItem
        
    }
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
