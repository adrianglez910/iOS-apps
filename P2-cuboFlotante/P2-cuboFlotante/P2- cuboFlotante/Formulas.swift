//
//  Formulas.swift
//  Practica 2
//
//  Created by g804 DIT UPM on 3/10/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class Formulas: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    struct Point {
        var x = 0.0
        var y = 0.0
    }
    
    private var g = 9.8
    private var w = 1.0
   
    
    var z = 0.0{
        didSet {
            updateCtes()
        }
    }
    

    var lado = 0.0 {
        didSet {
            updateCtes()
        }
    }
    
    var tiempo = 0.0 {
        didSet {
            updateCtes()
        }
    }
    
    private func updateCtes() {
        w = sqrt (2*g / lado)
    }
    
    func posicionpunto1() -> String {
        return String (format: "%.2f", (1/2*lado*cos(w*tiempo))) + "m"
    }
    
    func velocidadpunto1() -> String {
        return String (format: "%.2f", (-1/2*lado*w*sin(w*tiempo))) + "m/s"
    }
    
    func aceleracionpunto1() -> String {
       return String (format: "%.2f", (-g*cos(w*tiempo))) + "m/s^2"
    }
    
    func tiempoSlider() -> String {
        return String (tiempo) + "s"
    }
    
    func ladoSlider() -> String {
        return String (lado) + "m"
    }
    
    
    func posicionpunto() -> Double {
        return 1/2*lado*cos(w*tiempo)
    }
    
    func velocidadpunto() -> Double {
        return -1/2*lado*w*sin(w*tiempo)
    }
    
    func aceleracionpunto() -> Double {
        return -g*cos(w*tiempo)
    }
    

    
    
    // Dame la posicion de la masa en el instante t
    func posiciontiempo(_ t:Double) -> Double {
        return 1/2*lado*cos(w*t)
    }
    
    // Dame la velocidad de la masa en el instante t
    func velocidadtiempo(_ t:Double) -> Double {
        return -1/2*lado*w*sin(w*t)
    }
    func aceleraciontiempo(_ t:Double) -> Double {
        return -g*cos(w*t)
    }

}
