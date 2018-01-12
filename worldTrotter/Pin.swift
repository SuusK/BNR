//
//  Pin.swift
//  worldTrotter
//
//  Created by Susan Kamies on 28/10/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import MapKit
import UIKit

class Pin: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
