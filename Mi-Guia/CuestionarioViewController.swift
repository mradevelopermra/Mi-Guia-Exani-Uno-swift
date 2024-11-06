//
//  CuestionarioViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 16/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class CuestionarioViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var arrayDatosPreguntas:[[String:String]] = []
    var arrayDatos:[[String:String]] = []
    
    var parametroCuestionario:String = ""
    var numPreguntas: [String] = []
    var preguntasNumero:String = ""
    var ayuda:String = "Si"
     var modoJuego:String = "Si"
    var nombreMateria:String = ""
    var idMateria:String=""
    
    @IBOutlet weak var pregNumPicker: UIPickerView!
    
    //ayuda
    var categorySwitchIsOn:Bool =  false
    
    @IBOutlet weak var opAyuda: UISwitch!
    
    var arrayCategoriaFormaPago:[[String:String]] = []
    
    var espanol:[[String:AnyObject]] = []
    var razonamientoverbal:[[String:AnyObject]] = []
    var historiauniversal:[[String:AnyObject]] = []
    var historiademexico:[[String:AnyObject]] = []
    var geouniversal:[[String:AnyObject]] = []
    var geodemexico:[[String:AnyObject]] = []
    var civismo:[[String:AnyObject]] = []
    var razonamientomatematico:[[String:AnyObject]] = []
    var matematicas:[[String:AnyObject]] = []
    var fisica:[[String:AnyObject]] = []
    var quimica:[[String:AnyObject]] = []
    var bilogia:[[String:AnyObject]] = []
    
    
    @IBOutlet weak var numPregLeyenda: UILabel!
    
    @IBOutlet weak var ayudaLeyenda: UILabel!
    
    
    @IBOutlet weak var instruccionesLeyenda: UILabel!
    
    @IBOutlet weak var btnIniciar: UIButton!
    
    
    var tipoJuego:String=""
    
    @IBOutlet weak var opModoJuego: UISwitch!
    
    
    @IBAction func iniciarCuestionario(_ sender: Any) {
        
        
        print("pasa por iniciaCuestionario")
        
        if opAyuda.isOn {
            ayuda = "Si"
        } else {
            ayuda = "No"
        }
        
        
        if opModoJuego.isOn {
            modoJuego = "Si"
        } else {
            modoJuego = "No"
        }
        
        print("modoJuegoButton: \(modoJuego)")
        
        if(modoJuego=="Si"){
            if(tipoJuego=="Skyinvaders"){
                performSegue(withIdentifier: "verModuloJuego", sender: sender)
            }
            if(tipoJuego=="Crucigrama"){
                performSegue(withIdentifier: "crucigrama", sender: sender)
            }
            
        }else{
            performSegue(withIdentifier: "verModulo", sender: sender)
        }

    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("parametroCuestionario-CuestionarioViewController: \(parametroCuestionario)")
        
        nombreMateria = parametroCuestionario
        
        
        if nombreMateria == "Pensamiento matemático" {
            idMateria = "= 9"
            tipoJuego = "Skyinvaders"
            
        }
        if nombreMateria == "Pensamiento analítico" {
            idMateria = "IN(8, 2)"
            tipoJuego = "Skyinvaders"
            
        }
        if nombreMateria == "Estructura de la lengua" {
            idMateria = "= 1"
            tipoJuego = "Crucigrama"
            
        }
        if nombreMateria == "Comprensión lectora" {
            idMateria = "= 14"
            tipoJuego = "Crucigrama"
            
        }
        
        if nombreMateria == "Fenómenos biológicos y de la salud" {
            idMateria = "= 12"
            tipoJuego = "Skyinvaders"
            
        }
        if nombreMateria == "Fenómenos físico-químicos" {
            idMateria = "IN(10, 11)"
            tipoJuego = "Skyinvaders"
            
        }
        if nombreMateria == "Comprensión del entorno de México" {
            idMateria = "IN(4, 6)"
            tipoJuego = "Crucigrama"
            
        }
        if nombreMateria == "Inglés" {
            idMateria = "= 13"
            tipoJuego = "Crucigrama"
            
        }
        
        
        examenAleatorio()
        
        let totalPreguntas = String(arrayCategoriaFormaPago.count)
        
        numPreguntas = [
            "10",
            "20",
            "30",
            "40",
            totalPreguntas
        ]
        
        
        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numPregLeyenda.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        ayudaLeyenda.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
       // instruccionesLeyenda.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        btnIniciar.backgroundColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        //parsingWSAndSyncCategorias()
        
        opAyuda.addTarget(self, action:#selector(CuestionarioViewController.categorySwitchValueChanged(_:)), for: .valueChanged)
        
        print("parametroCuestionario-CuestionarioViewController: \(parametroCuestionario)")
        nombreMateria = parametroCuestionario
        

        if opAyuda.isOn {
            ayuda = "Si"
        } else {
            ayuda = "No"
        }
        

       /* if nombreMateria == "Pensamiento matemático" {
            idMateria = "= 9"
        }
        if nombreMateria == "Pensamiento analítico" {
            idMateria = "IN(8, 2)"
        }
        if nombreMateria == "Estructura de la lengua" {
            idMateria = "= 1"
        }
        if nombreMateria == "Comprensión lectora" {
            idMateria = "= 14"
        }
        
        if nombreMateria == "Fenómenos biológicos y de la salud" {
            idMateria = "= 12"
        }
        if nombreMateria == "Fenómenos físico-químicos" {
            idMateria = "IN(10, 11)"
        }
        if nombreMateria == "Comprensión del entorno de México" {
            idMateria = "IN(4, 6)"
        }
        if nombreMateria == "Inglés" {
            idMateria = "= 13"
        }
        
        
        examenAleatorio()
        
        let totalPreguntas = String(arrayCategoriaFormaPago.count)
        
        numPreguntas = [
            "10",
            "20",
            "30",
            "40",
            totalPreguntas
        ]*/
        

        // Do any additional setup after loading the view.
    }
    
    func examenAleatorio(){
        
        let objDaoIngresos = DataBase()
        
        self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        print("arrayDatos: \(arrayDatos.count)")
        
        if(arrayDatos.count>0){
             self.arrayCategoriaFormaPago = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo \(idMateria) ORDER BY RANDOM()") as! [[String : String]]
        }
        
        print("arrayCategoriaFormaPago: \(arrayCategoriaFormaPago.count)")
        
        
    }
    
    func parsingWSAndSyncCategorias(){
        
        
        let objDaoIngresos = DataBase()
        
        
        //objDaoIngresos.ejecutarDelete("DELETE FROM tblpreguntasmodulo")
        
        self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        print("arrayDatos: \(self.arrayDatos.count)")
        
        if(self.arrayDatos.count<=0){
            
            OperationQueue().addOperation {
                
                //let rutaJson = "http://www.pypsolucionesintegrales.com/ventas/get_examen_free.php"
                
                let rutaJson = "http://www.pypsolucionesintegrales.com/ventas/get_modulos.php"
                
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
                                self.arrayDatosPreguntas.append(result as! [String : String])
                            }
                            
                            // print("arrayDatosPreguntas: \(self.arrayDatosPreguntas)")
                            
                            self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
                            
                            print("arrayDatosOLD: \(self.arrayDatos.count)")
                            
                            print("arrayDatosPreguntas: \(self.arrayDatosPreguntas.count)")
                            
                            if(self.arrayDatos.count<634){
                                for k in 0 ..< self.arrayDatosPreguntas.count{
                                    
                                    print("imaPREG: \(self.arrayDatosPreguntas[k]["imagenpregunta"]!)")
                                    
                                    print("k: \(k)")
                                    
                                    objDaoIngresos.ejecutarInsert("INSERT INTO tblpreguntasmodulo (idmodulo, pregunta, respuestauno, respuestados, respuestatres, respuestacuatro, imagenpregunta, correcta, tooltip, imagentooltip) VALUES ('\(self.arrayDatosPreguntas[k]["idmodulo"]!)', '\(self.arrayDatosPreguntas[k]["pregunta"]!)', '\(self.arrayDatosPreguntas[k]["respuestauno"]!)', '\(self.arrayDatosPreguntas[k]["respuestados"]!)', '\(self.arrayDatosPreguntas[k]["respuestatres"]!)', '\(self.arrayDatosPreguntas[k]["respuestacuatro"]! )', '\(self.arrayDatosPreguntas[k]["imagenpregunta"]!)', '\(self.arrayDatosPreguntas[k]["correcta"]!)', '\(self.arrayDatosPreguntas[k]["tooltip"]!)', '\(self.arrayDatosPreguntas[k]["imagentooltip"]!)')")
                                    
                                    
                                }
                            }
                            

                            
                            self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
                            
                            print("arrayDatosAFTER: \(self.arrayDatos.count)")
 
                            
                        }
                    }catch{
                        print("Parse JSON failed")
                    }
                    
                    
                    
                }
                
                
                task.resume()
                
                
            }
            
            
        }
        

    }
    
    
    @objc func categorySwitchValueChanged(_ sender : UISwitch!){
        
        if sender.isOn {
            ayuda = "Si"
            
        } else {
            
            ayuda = "No"
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numPreguntas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Test"
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x: 0, y: 20, width: pickerView.bounds.width - 30, height: 80))

        var rowString = String()
        
        let myLabel = UILabel(frame: CGRect(x: 60, y: 0, width: pickerView.bounds.width - 90, height: 80 ))
        
        //  for i in 0  ..< concpetoIngreso.count  {
        
        rowString = numPreguntas[row]

        let selectedValue = pickerView.selectedRow(inComponent: 0)
        
        for i in 0  ..< numPreguntas.count  {
            
            if(i == selectedValue){
                preguntasNumero = numPreguntas[i]
            }
            
        }
        
    
        
        myLabel.text = rowString
        
        myView.addSubview(myLabel)

        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedValue = pickerView.selectedRow(inComponent: 0)
        
        for i in 0  ..< numPreguntas.count  {
            
            if(i == selectedValue){
                preguntasNumero = numPreguntas[i]
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // self.addCuestions()
        
        print("modoJuego_: \(modoJuego)")
        
        /*  for kk in 0..<arrayCompras.count {
         compra = arrayCompras[kk]["materia"]!
         }*/
        
        if(modoJuego=="Si"){
            if segue.identifier == "verModuloJuego"{
                
                // if(preguntasNumero=="10"){
                
                print("error in Concurrent Queue)")
                
                let objVista2 = segue.destination as! GameViewController
                objVista2.materia = nombreMateria
                objVista2.numPreguntas = preguntasNumero
                objVista2.ayuda = ayuda
                objVista2.arrayPreguntas = arrayCategoriaFormaPago
                
                /*  }else{
                 
                 self.boxView.removeFromSuperview()
                 // create the alert
                 let alert = UIAlertController(title: "Atención", message: "¡Para obtener mas de 10 preguntas es necesario obtener la versión PRO.!", preferredStyle: UIAlertController.Style.alert)
                 
                 // add an action (button)
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                 //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                 
                 // show the alert
                 self.present(alert, animated: true, completion: nil)
                 
                 /* // create the alert
                 let alertController = UIAlertController(title: "Atención", message: "¡Para obtener mas de 10 preguntas es necesario obtener la Licencia.!", preferredStyle: .alert)
                 
                 // Create OK button
                 
                 let OKAction = UIAlertAction(title: "Licencia", style: .default) { (action:UIAlertAction!) in
                 
                 for product in self.list {
                 let prodID = product.productIdentifier
                 print("prodIDcompra:  \(prodID)")
                 if(prodID == "com.mra.unampreguntaslicencia") {
                 self.p = product
                 self.buyProduct()
                 }
                 }
                 
                 // Code in this block will trigger when OK button tapped.
                 print("Ok button tapped");
                 
                 }
                 alertController.addAction(OKAction)
                 
                 // Create Cancel button
                 let restarurarCompra = UIAlertAction(title: "Restaurar compra", style: .default) { (action:UIAlertAction!) in
                 print("Restaurando compra");
                 self.restorePurchase()
                 }
                 alertController.addAction(restarurarCompra)
                 
                 // Create Cancel button
                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                 print("Cancel button tapped");
                 }
                 alertController.addAction(cancelAction)
                 
                 // Present Dialog message
                 self.present(alertController, animated: true, completion:nil)*/
                 }*/
                
                
                
            }
            
            if segue.identifier == "crucigrama"{
                
                //  if(preguntasNumero=="10"){
                
                /* if(compra=="CompraSi"){
                 
                 DispatchQueue.main.async {
                 
                 do {
                 self.examenAleatorio()
                 OperationQueue.main.addOperation {
                 self.boxView.removeFromSuperview()
                 }
                 } catch {
                 print("error in Concurrent Queue)")
                 }
                 }
                 
                 
                 }else{*/
                
                /*   DispatchQueue.main.async {
                 
                 do {
                 self.examenGratis()
                 OperationQueue.main.addOperation {
                 self.boxView.removeFromSuperview()
                 }
                 } catch {
                 print("error in Concurrent Queue)")
                 }
                 }*/
                
                //   }
                
                let objVista2 = segue.destination as! CrucigramaViewController
                objVista2.materia = nombreMateria
                objVista2.numPreguntas = preguntasNumero
                objVista2.ayuda = ayuda
                objVista2.arrayPreguntas = arrayCategoriaFormaPago
                
                /* }else{
                 
                 self.boxView.removeFromSuperview()
                 
                 // create the alert
                 let alert = UIAlertController(title: "Atención", message: "¡Para obtener mas de 10 preguntas es necesario obtener la versión PRO.!", preferredStyle: UIAlertController.Style.alert)
                 
                 // add an action (button)
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                 //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                 
                 // show the alert
                 self.present(alert, animated: true, completion: nil)
                 
                 
                 /* // create the alert
                 let alertController = UIAlertController(title: "Atención", message: "¡Para obtener mas de 10 preguntas es necesario obtener la Licencia.!", preferredStyle: .alert)
                 
                 // Create OK button
                 
                 let OKAction = UIAlertAction(title: "Licencia", style: .default) { (action:UIAlertAction!) in
                 
                 for product in self.list {
                 let prodID = product.productIdentifier
                 print("prodIDcompra:  \(prodID)")
                 if(prodID == "com.mra.unampreguntaslicencia") {
                 self.p = product
                 self.buyProduct()
                 }
                 }
                 
                 // Code in this block will trigger when OK button tapped.
                 print("Ok button tapped");
                 
                 }
                 alertController.addAction(OKAction)
                 
                 // Create Cancel button
                 let restarurarCompra = UIAlertAction(title: "Restaurar compra", style: .default) { (action:UIAlertAction!) in
                 print("Restaurando compra");
                 self.restorePurchase()
                 }
                 alertController.addAction(restarurarCompra)
                 
                 // Create Cancel button
                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                 print("Cancel button tapped");
                 }
                 alertController.addAction(cancelAction)
                 
                 // Present Dialog message
                 self.present(alertController, animated: true, completion:nil)*/
                 }*/
                
                
                
            }
        }else{
            if segue.identifier == "verModulo"{
                
                //   if(preguntasNumero=="10"){
                
                /*  if(compra=="CompraSi"){
                 
                 DispatchQueue.main.async {
                 
                 do {
                 self.examenAleatorio()
                 OperationQueue.main.addOperation {
                 self.boxView.removeFromSuperview()
                 }
                 } catch {
                 print("error in Concurrent Queue)")
                 }
                 }
                 
                 }else{*/
                
                /*  DispatchQueue.main.async {
                 
                 do {
                 self.examenAleatorio()
                 OperationQueue.main.addOperation {
                 self.boxView.removeFromSuperview()
                 
                 }
                 } catch {
                 print("error in Concurrent Queue)")
                 }
                 }*/
                
                // }
                
                print("nombreMateria_: \(self.nombreMateria)")
                print("arrayCategoriaFormaPago: \(self.arrayCategoriaFormaPago)")
                
                let objVista2 = segue.destination as! PreguntasModuloViewController
                objVista2.materia = self.nombreMateria
                objVista2.numPreguntas = self.preguntasNumero
                objVista2.ayuda = self.ayuda
                objVista2.arrayPreguntas = self.arrayCategoriaFormaPago
                
                /*  }else{
                 
                 self.boxView.removeFromSuperview()
                 
                 // create the alert
                 let alert = UIAlertController(title: "Atención", message: "¡Para obtener mas de 10 preguntas es necesario obtener la versión PRO.!", preferredStyle: UIAlertController.Style.alert)
                 
                 // add an action (button)
                 alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                 //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                 
                 // show the alert
                 self.present(alert, animated: true, completion: nil)
                 
                 /*    // create the alert
                 let alertController = UIAlertController(title: "Atención", message: "¡Para obtener mas de 10 preguntas es necesario obtener la Licencia.!", preferredStyle: .alert)
                 
                 // Create OK button
                 
                 let OKAction = UIAlertAction(title: "Licencia", style: .default) { (action:UIAlertAction!) in
                 
                 for product in self.list {
                 let prodID = product.productIdentifier
                 print("prodIDcompra:  \(prodID)")
                 if(prodID == "com.mra.unampreguntaslicencia") {
                 self.p = product
                 self.buyProduct()
                 }
                 }
                 
                 // Code in this block will trigger when OK button tapped.
                 print("Ok button tapped");
                 
                 }
                 alertController.addAction(OKAction)
                 
                 // Create Cancel button
                 let restarurarCompra = UIAlertAction(title: "Restaurar compra", style: .default) { (action:UIAlertAction!) in
                 print("Restaurando compra");
                 self.restorePurchase()
                 }
                 alertController.addAction(restarurarCompra)
                 
                 // Create Cancel button
                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                 print("Cancel button tapped");
                 }
                 alertController.addAction(cancelAction)
                 
                 // Present Dialog message
                 self.present(alertController, animated: true, completion:nil)*/
                 }*/
                
                
                
            }
        }
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
