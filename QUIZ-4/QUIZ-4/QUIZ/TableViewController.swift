//
//  TableViewController.swift
//  QUIZ
//
//  Created by g804 DIT UPM on 21/11/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit
struct Generico : Codable{
    let quizzes: [quizzes]
    let pageno: Int
    let nextUrl: String
}

struct quizzes: Codable{
    let id: Int
    let question: String
    let author: Author?
    let attachment: Attachment
    let favourite: Bool
    let tips:[String]
}

struct Author: Codable{
    let id: Int
    let isAdmin: Bool?
    let username: String
}

struct Attachment: Codable{
    let filename: String?
    let mime: String?
    let url: String?
}
class MyTableViewCell : UITableViewCell{
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var subtitulo: UILabel!
}
class TableViewController: UITableViewController {
    @IBAction func Lista(segue: UIStoryboardSegue){
    }
    let URLQuizzes = "https://quiz2019.herokuapp.com/api/quizzes/?token=dcdcba6936eaa287d796"
    var varquiz = [quizzes]()
 //   var images = [String:UIImage]()
    var pregunta = ""
    var img = UIImage(named: "icon1.png")!
    override func viewDidLoad() {
        super.viewDidLoad()
        redownload()
    }
    
    private func redownload(){
        varquiz = [quizzes]()
        tableView.reloadData()
        download(URLQuizzes)
    }
    
    //bien hecho
    func download(_ url1: String){
        
        if (url1 == ""){
            return
        }
       
        guard let url = URL(string: url1) else{
            print("Error 1 descargando página 1")
            return
        }
        DispatchQueue.global().async {
            // descargo el contenido de la url, el json
            if let data = try? Data(contentsOf: url){
                // decodificar el contenido
                let decoder = JSONDecoder()
                // lo guardo en paginaActual
                if let paginaActual = try? decoder.decode(Generico.self, from: data){
                    DispatchQueue.main.async {
                  /*      for i in paginaActual.quizzes{
                            self.varquiz.append(i)
                        }*/
                        self.varquiz.insert(contentsOf: paginaActual.quizzes, at: 0)
                        self.tableView.reloadData()
                    }
                    self.download(paginaActual.nextUrl)
                }
            }
            
        }
        
    
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return varquiz.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Quizzes Cell", for: indexPath) as! MyTableViewCell
        let fila = varquiz[indexPath.row]
        
        cell.foto?.image = downloadImage(fila.attachment.url!)
        cell.titulo?.text = fila.question
        cell.subtitulo?.text = fila.author?.username
       // cell.subtitulo?.textColor = UIFontWeightRed
        return cell
    }
    
    func downloadImage(_ string: String) -> UIImage{
        guard let url = URL(string: string) else{
            print ("Error en la descarga")
            return UIImage(named: "icon1.png")!
        }
        
        DispatchQueue.global().sync {
            if let data = try? Data(contentsOf: url){
                let imagen = UIImage(data: data)
                if (imagen == nil){self.img = UIImage(named: "icon1.png")!} else {
                    self.img = imagen!
                }
            }
        }
        return img
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "Show Question" {
            if let nc = segue.destination as? PreguntaController,
                let cell = sender as? MyTableViewCell,
            let ip = tableView.indexPath(for: cell){
                let q = varquiz[ip.row]
                nc.ask = q.question
                nc.URLimagen = q.attachment.url
                nc.pistas = q.tips
                nc.id = q.id
            }
        }
    }
        
}

