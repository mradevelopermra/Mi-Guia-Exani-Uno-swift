//
//  EscuelasViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 1/26/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class EscuelasViewController: UIViewController {

    
    
    //licenciatura uno
    var escuelaIUPicker:String = ""
    var imagenIUPicker:String = ""
    var puntajeIUPicker:String = ""
    
    //licenciatura dos
    var escuelaIUPickerDos:String = ""
    var imagenIUPickerDos:String = ""
    var puntajeIUPickerDos:String = ""
    
    //licenciatura tres
    var escuelaIUPickerTres:String = ""
    var imagenIUPickerTres:String = ""
    var puntajeIUPickerTres:String = ""
    
    var escuelaOpciones: [String] = []
    var puntajeOpciones: [String] = []
    
    var arrayDatos:[[String:String]] = []
    
    var arrayPreguntas:[[String:String]] = []
    var arrayDatosPreguntas:[[String:String]] = []

   /* func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.escuelaUno.reloadAllComponents();
        self.escuelaDos.reloadAllComponents();
        self.escuelaTres.reloadAllComponents();
    }*/
    
    //unwind
    @IBAction func volverVistaMoreViewController(unwindSegue: UIStoryboardSegue){
        print("Pintando vista escuelas")
    }
    
    var indicator = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        //self.view.backgroundColor = UIColor.blue

        
       /* self.escuelaUno.backgroundColor = UIColor.orange
        self.escuelaDos.backgroundColor = UIColor.red
        self.escuelaTres.backgroundColor = UIColor.black*/
        
        //instalar correctamente el sqlite
        DataBase.checkAndCreateDatabase()
        
        parsingWSAndSyncCategorias()

        // Do any additional setup after loading the view.
    }

    // Create the Activity Indicator
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var boxView = UIView()
    
    func addCuestions() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.white
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.gray
        textLabel.text = "Cargando..."
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }
    
    
    func parsingWSAndSyncCategorias(){
        
        
        let objDaoIngresos = DataBase()
        
        
        //objDaoIngresos.ejecutarDelete("DELETE FROM tblpreguntasmodulo")
        
        self.arrayPreguntas = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        print("arrayPreguntas: \(self.arrayPreguntas.count)")
        
        if(arrayPreguntas.count<603){
            objDaoIngresos.ejecutarDelete("DELETE FROM tblpreguntasmodulo")
        }
        
        if(self.arrayPreguntas.count<=0){
            // Add it to the view where you want it to appear
       /*     view.addSubview(activityIndicator)
            
            // Set up its size (the super view bounds usually)
            activityIndicator.frame = view.bounds
            // Start the loading animatio
            activityIndicator.startAnimating()*/
            
            addCuestions()
            
            OperationQueue().addOperation {
                
                //let rutaJson = "http://www.pypsolucionesintegrales.com/ventas/get_examen_free.php"
                
let rutaJson = "http://www.pypsolucionesintegrales.com/ventas/get_modulo_exani_uno.php"
                
                let urlJson = URL(string: rutaJson)
                // variable metodo post inicia
                
                var request = URLRequest(url: urlJson!)
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                let idMateria = "1"
                
                let postString = "mail=\(idMateria)"
                request.httpBody = postString.data(using: .utf8)
                
                // fin variable metodo post
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(error!)")
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response!)")
                    }
                    
                    //let responseString = String(data: data, encoding: .utf8)
                    
                    do{
                        if NSString(data:data, encoding: String.Encoding.utf8.rawValue) != nil {
                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject];
                            
                            for case let result in json["products"] as! [AnyObject] {
                                print("result = \(result)")
                                self.arrayDatosPreguntas.append(result as! [String : String])
                            }
                            
                            // print("arrayDatosPreguntas: \(self.arrayDatosPreguntas)")
                            
                            self.arrayPreguntas = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
                            
                            print("arrayDatosOLD: \(self.arrayPreguntas.count)")
                            
                            print("arrayDatosPreguntas: \(self.arrayDatosPreguntas.count)")
                            
                            if(self.arrayPreguntas.count<603){
                                for k in 0 ..< self.arrayDatosPreguntas.count{
                                    
                                    print("imaPREG: \(self.arrayDatosPreguntas[k]["imagenpregunta"]!)")
                                    
                                    print("k: \(k)")
                                    
                                    objDaoIngresos.ejecutarInsert("INSERT INTO tblpreguntasmodulo (idmodulo, pregunta, respuestauno, respuestados, respuestatres, respuestacuatro, imagenpregunta, correcta, tooltip, imagentooltip) VALUES ('\(self.arrayDatosPreguntas[k]["idmodulo"]!)', '\(self.arrayDatosPreguntas[k]["pregunta"]!)', '\(self.arrayDatosPreguntas[k]["respuestauno"]!)', '\(self.arrayDatosPreguntas[k]["respuestados"]!)', '\(self.arrayDatosPreguntas[k]["respuestatres"]!)', '\(self.arrayDatosPreguntas[k]["respuestacuatro"]! )', '\(self.arrayDatosPreguntas[k]["imagenpregunta"]!)', '\(self.arrayDatosPreguntas[k]["correcta"]!)', '\(self.arrayDatosPreguntas[k]["tooltip"]!)', '\(self.arrayDatosPreguntas[k]["imagentooltip"]!)')")
                                    
                                    
                                }
                            }
                            
                            
                            
                            self.arrayPreguntas = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
                            
                            print("arrayDatosAFTER: \(self.arrayPreguntas.count)")
                            
                            OperationQueue.main.addOperation {
                                //self.activityIndicator.removeFromSuperview()
                                //self.activityIndicator.stopAnimating()

                                    self.boxView.removeFromSuperview()
                            }
                            
                        }
                    }catch{
                        print("Parse JSON failed")
                    }
                    
                    
                    
                }
                
                
                task.resume()
                
                //self.stopLoading()
                
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
