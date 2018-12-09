//
//  ViewController.swift
//  orange
//
//  Created by g804 DIT UPM on 30/10/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var boton1: UIButton!
    @IBOutlet weak var bienvenidoLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var fechaFinalLabel: UILabel!
    @IBOutlet weak var labelcumpleaños: UILabel!
    
    var myCumpleanos: Date?
    var myEnamorar: Date?
    var boda: Date?
    
    let guardarFecha = UserDefaults.standard
    
    var bdy: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBL()
    }
    
    func updateBL(){
        if let bd = myEnamorar{
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .long
            dateformatter.timeStyle = .none
            dateformatter.locale = Locale(identifier: "es_ES")
            let t = dateformatter.string(from: bd) // Jan 2, 2001
            fechaLabel.text = "Te enamoraste el \(t)"
            guardarFecha.set(bd, forKey: "FechaAmor")
        } else {
            fechaLabel.text = "No se cuando te enamoraste"
        }
        if let bd2 = myCumpleanos{
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .long
            dateformatter.timeStyle = .none
            dateformatter.locale = Locale(identifier: "es_ES")
            let t = dateformatter.string(from: bd2) // Jan 2, 2001
            labelcumpleaños.text = "Naci el \(t)"
            guardarFecha.set(bd2, forKey: "FechaAmor")
        } else {
            labelcumpleaños.text = "No se cuando naciste"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCumpleaños"{
            if let bvc = segue.destination as? ViewController3 {
                if let b = myEnamorar {
                    bvc.enamorar = b
                }
            }
        }
        if segue.identifier == "SelectCumpleaños"{
            if let bvc = segue.destination as? ViewController3 {
                if let b2 = myCumpleanos {
                    bvc.nacimiento = b2
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       let defaults = UserDefaults.standard
        defaults.set(myEnamorar, forKey: "enam")
        defaults.set(myCumpleanos, forKey: "cump")
        defaults.synchronize() // Forzar la sincronización ahora
    }
    
    
    @IBAction func gotoRoot(_ segue:UIStoryboardSegue) {
        
        if segue.identifier == "seok" {
            if let bvc = segue.source as? ViewController3 {               
                    myCumpleanos = bvc.nacimiento
                    myEnamorar = bvc.enamorar
                    updateBL()
                    
                }
                
            }
        }
    }
    
    




