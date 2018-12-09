//
//  ViewController3.swift
//  orange
//
//  Created by g804 DIT UPM on 30/10/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var fechaEnamorar: UIDatePicker!
   
    @IBOutlet weak var boton3: UIButton!
    
    
    var enamorar: Date = Date()
    var nacimiento: Date = Date()
    var diaBoda : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "seok"{
            if  nacimiento > fechaEnamorar.date {
                let alert = UIAlertController(title: "Error", message: "No puedes enamorarte antes de nacer", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(aa : UIAlertAction) in print("nijrgnjkr")}))
                
                present(alert, animated: true)
                return false
            }
            
            if fechaEnamorar.date > Date() {
                let alert = UIAlertController(title: "Error", message: "No puedes enamorarte en el futuro", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(aa : UIAlertAction) in print("nijrgnjkr")}))
                
                present(alert, animated: true)
                return false
            }
            
        }
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        enamorar = fechaEnamorar.date
        
        if let mostrarBoda = segue.destination as? ViewController {
            diaBoda = fechaEnamorar.date + fechaEnamorar.date.timeIntervalSince(nacimiento)
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .long
            dateformatter.timeStyle = .none
            dateformatter.locale = Locale(identifier: "es_ES")
            mostrarBoda.boda = diaBoda
            mostrarBoda.fechaFinalLabel.text = dateformatter.string(from: diaBoda!)
        }
       

 
    }
}
