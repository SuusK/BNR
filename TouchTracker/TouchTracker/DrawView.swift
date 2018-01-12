//
//  DrawView.swift
//  TouchTracker
//
//  Created by Susan Kamies on 11/01/2018.
//  Copyright © 2018 Susan Kamies. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    //MARK: variables
    
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    var currentCircle = [NSValue:Circle]()
    var finishedCircles = [Circle]()
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red{
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    
    
    override func draw(_ rect: CGRect) {
        //Teken lijnen die af zijn in het zwart
        finishedLineColor.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            stroke(line)
            let angle = angleBetweenPoints(startingPoint: line.begin, endPoint: line.end)
            if angle >= 90 && angle < 180 {
                currentLineColor = UIColor.green
            }
            else if angle >= 180 && angle < 270 {
                currentLineColor = UIColor.blue
            }
            else if angle >= 270 && angle < 360 {
                currentLineColor = UIColor.yellow
            }
            else {
                currentLineColor = UIColor.red
            }
        }
        
        finishedLineColor.setStroke()
        for circle in finishedCircles {
            let path = UIBezierPath(ovalIn: circle.rectangle)
            path.lineWidth = lineThickness
            path.lineCapStyle = .round
            
            path.stroke()

        }
        
        currentLineColor.setStroke()
        for (_, circle) in currentCircle {
            let path = UIBezierPath(ovalIn: circle.rectangle)
            path.lineWidth = lineThickness
            path.lineCapStyle = .round
            
            path.stroke()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Log statement om de volgorde van events te kunnen bekijken
        print(#function)
        if touches.count == 2 {
            let firstTouch = touches.first!
            let lastTouch = touches.reversed().first!
            
            let firstLocation = firstTouch.location(in: self)
            let lastLocation  = lastTouch.location(in: self)
            
            let xDist = (firstLocation.x + lastLocation.x) / 2
            let yDist = (firstLocation.y + lastLocation.y) / 2
            
            let diameter = distanceBetweenTwoPoints(point1: firstLocation, point2: lastLocation)
            
            
            let rectangle = CGRect(x: xDist - (diameter/2), y: yDist - (diameter/2) , width: diameter , height: diameter)
            
            let key = NSValue(nonretainedObject: firstTouch)
            currentCircle[key] = Circle(rectangle: rectangle)
            
            
        }
        else {
            for touch in touches {
                let location = touch.location(in: self)
                
                let newLine = Line(begin: location, end: location)
                
                let key = NSValue(nonretainedObject: touch)
                currentLines[key] = newLine
                
                
            }
        }
        setNeedsDisplay()
    }
    
    func distanceBetweenTwoPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let xDist = abs(point1.x - point2.x)
        let yDist = abs(point1.y - point2.y)
        
        return CGFloat(sqrt(xDist * xDist) + sqrt(yDist * yDist))
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        if touches.count == 2 {
            let firstTouch = touches.first!
            let lastTouch = touches.reversed().first!
            
            let firstLocation = firstTouch.location(in: self)
            let lastLocation  = lastTouch.location(in: self)
            
            let xDist = (firstLocation.x + lastLocation.x) / 2
            let yDist = (firstLocation.y + lastLocation.y) / 2
            
            print("\(xDist)")
            print("\(yDist)")
            
            let diameter = distanceBetweenTwoPoints(point1: firstLocation, point2: lastLocation)
            
            
            let rectangle = CGRect(x: xDist - (diameter/2), y: yDist - (diameter/2) , width: diameter , height: diameter)
            
            let key = NSValue(nonretainedObject: firstTouch)
            currentCircle[key]? = Circle(rectangle: rectangle)
            
        }
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        if touches.count == 2 {
            let firstTouch = touches.first!
            
            let key = NSValue(nonretainedObject: firstTouch)
            if let circle = currentCircle[key] {
                finishedCircles.append(circle)
                currentCircle.removeValue(forKey: key)
            }
            
        }
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        
        setNeedsDisplay()
    }
    
    func originPoint(start: CGPoint, end: CGPoint) -> CGPoint {
        return CGPoint(x: end.x - start.x, y: end.y - start.y)
    }
    
    
    func angleBetweenPoints(startingPoint: CGPoint, endPoint: CGPoint) -> Double {
        
        let origin = originPoint(start: startingPoint, end: endPoint)
        let bearingRadius = atan2f(Float(origin.y), Float(origin.x))
        var  bearingDegrees = bearingRadius * Float((180.0 / Double.pi))
        
        bearingDegrees = bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)
        
        return Double(bearingDegrees)
    }
}
