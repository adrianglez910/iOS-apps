//
//  WebViewController.swift
//  Pokemon
//
//  Created by g804 DIT UPM on 7/11/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var race: Race?
    @IBOutlet weak var PokeWiki: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // URL a mostrar
        var str = "http://es.pokemon.wikia.com"
        if race != nil {
            // Poner nombre de la raza como titulo de la Navigation Bar
            title = race!.name
            // Añadir la raza al URL escapando caracteres conflictivos
            if let path = "wiki/\(race!.name)" .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
                str = "\(str)/\(path)"
            }
        } else {
            // Poner Pokedex como titulo de la Navigation Bar
            title = "Pokedex" }
        if let url = URL(string: str) { let req = URLRequest(url: url)
            PokeWiki.loadRequest(req) }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
