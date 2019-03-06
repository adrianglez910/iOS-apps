//
//  RazaTableViewController.swift
//  Pokemon
//
//  Created by g804 DIT UPM on 7/11/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

class RazaTableViewController: UITableViewController {		
    
    var pokedexModel = PokedexModel()

    var races: [Race]!
    var nombre: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    /*
     override func viewWillAppear(_ animated: Bool) {
     clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
     super.viewWillAppear(animated)
     }
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return races.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Race Cell", for: indexPath)
        
        // Configure the cell...
        let pokemon = races[indexPath.row]
        
        cell.imageView?.image = UIImage(named: pokemon.icon)
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = String(pokemon.code)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return "Pokemon de tipo " + nombre
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "WikiPokemon" {
            // sender es la celda de la tabla que disparo el segue.
            if let nc = segue.destination as? UINavigationController,
                let wvc = nc.topViewController as? WebViewController,
                let cell = sender as? UITableViewCell,
                let ip = tableView.indexPath(for: cell) {
                
                wvc.race = races[ip.row]
                
                wvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                wvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
