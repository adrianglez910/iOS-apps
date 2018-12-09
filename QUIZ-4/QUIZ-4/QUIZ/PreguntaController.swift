//
//  PreguntaController.swift
//  QUIZ
//
//  Created by g804 DIT UPM on 21/11/18.
//  Copyright © 2018 g804 DIT UPM. All rights reserved.
//

import UIKit

struct AnswerStruct : Codable{
    let quizId: Int?
    let answer: String?
    let result: Bool?
}

class PreguntaController: UIViewController {
    @IBOutlet weak var comprueba: UIButton!
    @IBOutlet weak var respuestaa: UITextField!
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBAction func Pregunta(segue: UIStoryboardSegue){
    }
    
    @IBAction func teclado(_ sender: UITapGestureRecognizer) {
        self.respuestaa.endEditing(true)
    }
    
    var id: Int = 0
    var ask: String!
    var URLimagen: String!
    var pistas = [String]()
    
    
    @IBAction func compruebaButton(_ sender: Any) {
        
        let ac = AlertController()        
        let text = String(respuestaa.text!)
        let urlString = "https://quiz2019.herokuapp.com/api/quizzes/\(id)/check?answer=\(text!)&token=dcdcba6936eaa287d796"
        
         
         guard let url = URL(string: urlString) else{
            print("\(id)")
            print("Error 1 descargando página 1")
            return
         }
        
         DispatchQueue.global().async {
         // descargo el contenido de la url, el json
         if let data = try? Data(contentsOf: url){
         // decodificar el contenido
            let decoder = JSONDecoder()
            // lo guardo en paginaActual
            if let respuestaComprobar = try? decoder.decode(AnswerStruct.self, from: data){
                DispatchQueue.main.async {
                    if respuestaComprobar.result == true {
                        ac.showAlert("Respuesta correcta")
                        self.present(ac.alert!, animated: true)
                        self.resultado.text = "Respueta correcta"
                    } else {
                        ac.showAlert("Respuesta incorrecta")
                        self.present(ac.alert!, animated: true)
                        self.resultado.text = "Respuesta incorrecta"
                    }
                }
            }
         }
         }
    }
   
    
   // var images = [String:UIImageView]()
    var img = UIImage(named: "icon1.png")!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        Question.text = ask
        imageView?.image = downloadImage(URLimagen)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Tips" {
            if let nc = segue.destination as? PistasTableViewController{
                nc.pistas = pistas
            }
        }
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
