//
//  ViewController2.swift
//  orange
//
//  Created by g804 DIT UPM on 30/10/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var boton2: UIButton!
    @IBOutlet weak var fechaCumpleaños: UIDatePicker!

    var cumpleaños: Date = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fechaCumpleaños.date = cumpleaños
       
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "SelectEnamorar"{
            if fechaCumpleaños.date > Date() {
                let alert = UIAlertController(title: "Error en la fecha", message: "No puedes nacer en el futuro", preferredStyle: .alert)
                        
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(aa : UIAlertAction) in print("nijrgnjkr")}))
                        
                present(alert, animated: true)
                return false
            }
            
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "SelectEnamorar"{
            if let ivc = segue.destination as? ViewController3{
              cumpleaños = fechaCumpleaños.date
              ivc.nacimiento = cumpleaños
        
            }}
    


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
