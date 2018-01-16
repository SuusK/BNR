//
//  Line.swift
//  TouchTracker
//
//  Created by Susan Kamies on 10/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
    var lineThickness = CGFloat.init(15)
    var lineColor: UIColor
}
