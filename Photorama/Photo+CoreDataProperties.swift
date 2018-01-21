//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Susan Kamies on 21/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var dateTaken: NSDate?
    @NSManaged public var photoID: String?
    @NSManaged public var remoteURL: NSURL?
    @NSManaged public var title: String?
    @NSManaged public var views: Int64

}
