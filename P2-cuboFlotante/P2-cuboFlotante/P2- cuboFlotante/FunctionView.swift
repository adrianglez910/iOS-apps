//
//  FunctionView.swift
//  Practica 2
//
//  Created by g804 DIT UPM on 1/10/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit


struct Point {
    var x = 0.0
    var y = 0.0
}



protocol FunctionViewDataSource: class {
    
    func startTimeOfFunctionView(_ functionView: FunctionView) -> Double
    func endTimeOfFunctionView(_ functionView: FunctionView) -> Double
    func pointOfFunctionView(_ functionView: FunctionView, atTime time: Double) -> Point
    func pointsOfInterestFor(_ functionView: FunctionView) -> [Point]
}


@IBDesignable
class FunctionView: UIView {
    
    @IBInspectable
    var lineWidth : Double = 3.0
    
    @IBInspectable
    var trajectoryColor : UIColor = UIColor.red
    
    @IBInspectable
    var pointColor : UIColor = UIColor.black
    
    @IBInspectable
    var textX: String = "x"
    
    @IBInspectable
    var textY: String = "y"
    
    

    // Numero de puntos en el eje X por unidad representada
    var scaleX: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Numero de puntos en el eje Y por unidad representada
    var scaleY: Double = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Resolucion: Numero de muestras tomadas
    var resolution: Double = 500 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var formulas: Formulas!
    
    #if TARGET_INTERFACE_BUILDER
    var dataSource: FunctionViewDataSource!
    #else
    weak var dataSource: FunctionViewDataSource!
    #endif
    
    override func prepareForInterfaceBuilder() {
        
        class FakeDataSource: FunctionViewDataSource {
            
            func startTimeOfFunctionView(_ functionView: FunctionView) -> Double  {return 0.0}
            
            func endTimeOfFunctionView(_ functionView: FunctionView) -> Double {return 200.0}
            
            func pointOfFunctionView(_ functionView: FunctionView, atTime time: Double) -> Point {
                return Point(x: time, y: time.truncatingRemainder(dividingBy: 50))
            }
            func pointsOfInterestFor(_ functionView: FunctionView) -> [Point]{
                return []
            }
        }
        
        dataSource = FakeDataSource()
    }
    
    
    override func draw(_ rect: CGRect) {
        drawAxis()
        drawTrajectory()
        drawPOI()
        drawTexts()
    }
    
    private func drawAxis() {
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: width/2, y: 0))
        path1.addLine(to: CGPoint(x: width/2, y: height))
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: height/2))
        path2.addLine(to: CGPoint(x: width, y: height/2))
        
        UIColor.black.setStroke()
        
        path1.lineWidth = 1
        path1.stroke()
        path2.lineWidth = 1
        path2.stroke()
    }
    
    private func drawTrajectory() {
        
        let startTime = dataSource.startTimeOfFunctionView(self)
        let endTime = dataSource.endTimeOfFunctionView(self)
        let incrTime = max((endTime - startTime) / resolution , 0.01)
        
        let path = UIBezierPath()
        
        var point = dataSource.pointOfFunctionView(self, atTime: startTime)
        
        var px = pointForX(point.x)
        
        var py = pointForY(point.y)
        path.move(to: CGPoint(x: px, y: py))
        
        for t in stride(from: startTime, to: endTime, by: incrTime) {
            point = dataSource.pointOfFunctionView(self, atTime: t)
            px = pointForX(point.x)
            py = pointForY(point.y)
            path.addLine(to: CGPoint(x: px, y: py))
        }
        
        path.lineWidth = CGFloat(lineWidth)
        trajectoryColor.set()
        path.stroke()
    }
    
    
    private func drawPOI() {
        for p in dataSource.pointsOfInterestFor(self) {
            
            let px = pointForX(p.x)
            let py = pointForY(p.y)
            
            let path = UIBezierPath(ovalIn: CGRect(x: px-4, y: py-4, width: 8, height: 8))
            
            UIColor.black.set()
            
            path.stroke()
            path.fill()
        }
        
    }
    private func drawTexts() {
        
        let width = bounds.size.width
        let height = bounds.size.height
        
        let attrs = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]
        
        let offset: CGFloat = 4 // Separacion del texto al eje y al borde
        
        let asX = NSAttributedString(string: textX, attributes: attrs)
        let sizeX = asX.size()
        let posX = CGPoint(x: width - sizeX.width - offset, y: height/2 + offset)
        asX.draw(at: posX)
        
        let asY = NSAttributedString(string: textY, attributes: attrs)
        let posY = CGPoint(x: width/2 + offset, y: offset)
        asY.draw(at: posY)
    }
    private func pointForX(_ x: Double) -> CGFloat {
        
        let width = bounds.size.width
        return width/2 + CGFloat(x*scaleX)
    }
    
    private func pointForY(_ y: Double) -> CGFloat {
        
        let height = bounds.size.height
        return height/2 - CGFloat(y*scaleY)
    }
    
    
}

