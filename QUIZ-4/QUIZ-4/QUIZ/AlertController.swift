//
//  AlertController.swift
//  QUIZ
//
//  Created by g804 DIT UPM on 26/11/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {

    
    var alert: UIAlertController?
    
    func showAlert(_ title: String) {
        
        alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert?.addAction(UIAlertAction(title: "OK", style: .default))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
