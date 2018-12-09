//
//  ViewController.swift
//  P2- cuboFlotante
//
//  Created by g804 DIT UPM on 5/10/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FunctionViewDataSource {

  
    @IBOutlet weak var PosicionFunctionView: FunctionView!
    
    @IBOutlet weak var VelocidadFunctionView: FunctionView!
    
    @IBOutlet weak var AceleracionFunctionView: FunctionView!
    
    @IBOutlet weak var Velocidad2FunctionView: FunctionView!
    @IBOutlet weak var ladoSlider: UILabel!
    
    @IBOutlet weak var tiempoSlider: UILabel!
    
    @IBOutlet weak var Slider1: UISlider!
    
    @IBOutlet weak var Slider2: UISlider!

    @IBOutlet weak var posicion: UILabel!
    
    @IBOutlet weak var velocidad: UILabel!
    
    @IBOutlet weak var aceleracion: UILabel!
    
    var formulas: Formulas!
    override func viewDidLoad() {
        formulas = Formulas()
        
        PosicionFunctionView.dataSource = self
        VelocidadFunctionView.dataSource = self
        AceleracionFunctionView.dataSource = self
        Velocidad2FunctionView.dataSource = self
        
        PosicionFunctionView.scaleX = 20.0
        PosicionFunctionView.scaleY = 30.0
        
        VelocidadFunctionView.scaleX = 30.0
        VelocidadFunctionView.scaleY = 15.0
        
        AceleracionFunctionView.scaleX = 30.0
        AceleracionFunctionView.scaleY = 2.0
        
        Velocidad2FunctionView.scaleX = 30.0
        Velocidad2FunctionView.scaleY = 30.0
        
        
        Slider1.sendActions(for: .valueChanged)
        Slider2.sendActions(for: .valueChanged)
    }
    @IBAction func Lado(_ sender: UISlider) {
        formulas.lado = Double(sender.value)
        ladoSlider.text = formulas.ladoSlider()
        posicion.text = formulas.posicionpunto1()
        velocidad.text = formulas.velocidadpunto1()
        aceleracion.text = formulas.aceleracionpunto1()
        
        PosicionFunctionView.setNeedsDisplay()
        VelocidadFunctionView.setNeedsDisplay()
        AceleracionFunctionView.setNeedsDisplay()
        Velocidad2FunctionView.setNeedsDisplay()
    }
    
    @IBAction func tiempoSlider(_ sender: UISlider) {
        formulas.tiempo = Double(sender.value)
        posicion.text = formulas.posicionpunto1()
        velocidad.text = formulas.velocidadpunto1()
        aceleracion.text = formulas.aceleracionpunto1()
        tiempoSlider.text = formulas.tiempoSlider()
        
        
        PosicionFunctionView.setNeedsDisplay()
        VelocidadFunctionView.setNeedsDisplay()
        AceleracionFunctionView.setNeedsDisplay()
        Velocidad2FunctionView.setNeedsDisplay()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimeOfFunctionView(_ functionView: FunctionView) -> Double {
        return 0
    }
    
    
    func endTimeOfFunctionView(_ functionView: FunctionView) -> Double {
        return 10
    }
    
    
    func pointOfFunctionView(_ functionView: FunctionView, atTime time: Double) -> Point {
        
        
        
        switch functionView {
            
        case PosicionFunctionView:
            let x = time
            let y = formulas.posiciontiempo(time)
            return Point(x:x, y:y)
            
        case VelocidadFunctionView:
            let x = time
            let y = formulas.velocidadtiempo(time)
            return Point(x:x, y:y)
            
        case AceleracionFunctionView:
            let x = time
            let y = formulas.aceleraciontiempo(time)
            return Point(x:x, y:y)
            
        case Velocidad2FunctionView:
            let x = formulas.posiciontiempo(time)
            let y = formulas.velocidadtiempo(time)
            return Point(x:x, y:y)
            
        default:
            return Point(x:0, y:0)
            
        }
    }
    
    func pointsOfInterestFor(_ functionView: FunctionView) -> [Point] {
        switch functionView {
        case PosicionFunctionView:
            
            // Velocidad de salida del agua en el instante actual
            let v = formulas.tiempo
            let h = formulas.posicionpunto()
            return [Point(x:v, y: h)]
            
        case VelocidadFunctionView:
            
            // Velocidad de salida del agua en funcion de la altura de agua en el deposito
            let v = formulas.tiempo
            let h = formulas.velocidadpunto()
            return [Point(x: v, y: h)]
            
        case AceleracionFunctionView:
            
            // Altura de agua en el deposito en el instante actual
            let v = formulas.tiempo
            let h = formulas.aceleracionpunto()
            return [Point(x: v, y: h)]
            
        case Velocidad2FunctionView:
            
            // Altura de agua en el deposito en el instante actual
            let v = formulas.posicionpunto()
            let h = formulas.velocidadpunto()
            return [Point(x: v, y: h)]
            
            
        default:
            return []
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}

