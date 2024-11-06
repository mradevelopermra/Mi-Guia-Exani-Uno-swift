//
//  HerramientasViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 1/28/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class HerramientasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tipoHerramienta: [String] = []
    var imagenesHerramienta: [String] = []
    
    var nombreHerramienta:String = ""
    
    var datoRecibido:String = ""
    
    var arrayEscuelas:[[String:String]] = []
    
    var arrayDatos:[[String:String]] = []
    
    var arrayHistoricos:[[String:String]] = []
    
    var arrayMaterias:[[String:String]] = []
    
    
    @IBOutlet weak var tablaHerramientas: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipoHerramienta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "herramienta", for: indexPath) as! HerramientasTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        let width = CGFloat(2.0)
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        let borderColor: UIColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        cell.layer.borderColor = borderColor.cgColor
        
        //color a los datos
        cell.nomHerramienta.textColor = borderColor
        
        // Configure the cell...
        let nombreCategoria = tipoHerramienta[indexPath.row]
        let imagen = imagenesHerramienta[indexPath.row]
        
        cell.nomHerramienta.text = nombreCategoria
        cell.imaHerramienta.image = UIImage(named: imagen as String)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nombreHerramienta = tipoHerramienta[indexPath.row]
        
        
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Examen simulacro" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "ressexamensim",
                             sender: self)
            }
            
        }
        
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Resultado Examen Simulacro" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "resexamsimu",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Mi Diagnostico" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "midiagnostico",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Resultados por materia" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "historicoPorMateria",
                             sender: self)
            }
            
        }
        
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Resultados Históricos" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "reshistoricosExamnen",
                             sender: self)
            }
            
        }
        if let _ = tableView.cellForRow(at: indexPath) {
            if nombreHerramienta == "Reportar un problema" {
                datoRecibido = nombreHerramienta
                performSegue(withIdentifier: "reportar",
                             sender: self)
            }
            
        }


        /*  if let _ = tableView.cellForRow(at: indexPath) {
         if nombreHerramienta == "Calculadora" {
         performSegue(withIdentifier: "",
         sender: self)
         }
         
         }*/
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
       /* DataBase.checkAndCreateDatabase()
        
        //instanciar y definir dao
        
        let objDao = DataBase()
        
        arrayMaterias = objDao.ejecutarSelect("SELECT * FROM materia") as! [[String : AnyObject]] as! [[String : String]]*/
        
        tablaHerramientas.reloadData()
        
        tipoHerramienta = [
             "Examen simulacro",
             "Resultado Examen Simulacro",
             "Mi Diagnostico",
             "Resultados por materia",
             "Resultados Históricos",
             "Reportar un problema"
             // "Calculadora"
         ]
         
         
         imagenesHerramienta = [
             "examen_simulacro_ios.png",
             "resultado_es_ios.png",
             "mi_diagnostico_ios.png",
             "resultados_historicos_ios.png",
             "resultados_materia_ios.png",
             "reportar_problema_ios.png"
             //    "calc.png"
         ]
        
        refrescaInfo()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refrescaInfo()
        
    }
    
    func refrescaInfo(){
        let objDaoIngresos = DataBase()
        
        arrayEscuelas = objDaoIngresos.ejecutarSelect("SELECT * FROM opcionesescuelas") as! [[String : String]]
        
        arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM examenresultados") as! [[String : String]]
        
        
        arrayHistoricos = objDaoIngresos.ejecutarSelect("SELECT * FROM examen") as! [[String : String]]
        
        
        
        print("arrayDatos \(arrayDatos.count)")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("arrayEscuelas \(arrayEscuelas.count)")
        
        if segue.identifier == "ressexamensim"{
             
             if var indexPath = tablaHerramientas.indexPathForSelectedRow{
                 
                 let objMateria = self.tipoHerramienta[indexPath.row]
                 print("objMateria: \(objMateria)")
                 
                 let numPreguntas = "120"
                 let objVista2 = segue.destination as! SecondViewController
                 
                 objVista2.preguntasRealizadas = numPreguntas
                 
             }
             
             
         }
        
        
        if segue.identifier == "reportar"{
            
            if var indexPath = tablaHerramientas.indexPathForSelectedRow{
                let objMateria = self.tipoHerramienta[indexPath.row]
                print("objMateria: \(objMateria)")
                
                let numPreguntas = "80"
                let objVista2 = segue.destination as! ReportarProblemaViewController
                
                objVista2.preguntasRealizadas = numPreguntas
                
            }
            
            
        }
        
        
        if segue.identifier == "resexamsimu"{
  
               // if(arrayDatos.count==80){
                    
                    if var indexPath = tablaHerramientas.indexPathForSelectedRow{
                        let objMateria = self.tipoHerramienta[indexPath.row]
                        print("objMateria: \(objMateria)")
                        
                        let objDestinoDetalle = segue.destination as! DiagnosticoExamenViewController
                        objDestinoDetalle.parametroCuestionario = objMateria
                    }
                    
               /* }else{
                    
                    // create the alert
                    let alert = UIAlertController(title: "Atención", message: "¡Para ver tu resultado del examen simulacro, primero realiza o completa el examen simulacro!", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    tablaHerramientas.reloadData()
                }*/
                
                

            
        }
        
        if segue.identifier == "midiagnostico"{
   
              //  if(arrayDatos.count==80){
                    
                    if var indexPath = tablaHerramientas.indexPathForSelectedRow{
                        let objMateria = self.tipoHerramienta[indexPath.row]
                        print("objMateria: \(objMateria)")
                        
                        let objDestinoDetalle = segue.destination as! ResultadosDiagnosticoViewController
                        objDestinoDetalle.parametroCuestionario = objMateria
                    }
                    
               /* }else{
                    
                    // create the alert
                    let alert = UIAlertController(title: "Atención", message: "¡Para ver tu diagnóstico, primero realiza o completa el examen simulacro!", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    tablaHerramientas.reloadData()
                }*/
                

        }
        
        if segue.identifier == "historicoPorMateria"{
            
              //  if(arrayMaterias.count>0){
                    
                    if var indexPath = tablaHerramientas.indexPathForSelectedRow{
                        let objMateria = self.tipoHerramienta[indexPath.row]
                        print("objMateria: \(objMateria)")
                        
                        let objDestinoDetalle = segue.destination as! ResulHisMateriaViewController
                        objDestinoDetalle.parametroCuestionario = objMateria
                    }
                    
               /* }else{
                    
                    // create the alert
                    let alert = UIAlertController(title: "Atención", message: "¡Para ver tus resultados historicos, primero realiza el cuestionario de alguna materia!", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    tablaHerramientas.reloadData()
                }*/
                

        }
        
        if segue.identifier == "reshistoricosExamnen"{
            
             //   if(arrayHistoricos.count>0){
                    
                    if var indexPath = tablaHerramientas.indexPathForSelectedRow{
                        let objMateria = self.tipoHerramienta[indexPath.row]
                        print("objMateria: \(objMateria)")
                        
                        let correctasFinalTotal = "999"
                        let numPreguntas = "999"
                        let objVista2 = segue.destination as! ResulExamenViewController
                        
                        objVista2.preguntasRealizadas = numPreguntas
                        objVista2.resultadoFinal = correctasFinalTotal
                    }
                    
               /* }else{
                    
                    // create the alert
                    let alert = UIAlertController(title: "Atención", message: "¡Para ver tus resultados históricos, primero realiza el examen simulacro!", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    tablaHerramientas.reloadData()
                }*/
                
            
        }
        
        
        
        
        
        
        
    }
    
    //unwind
    @IBAction func volverVistaHerramientasViewController(unwindSegue: UIStoryboardSegue){
        refrescaInfo()
        tablaHerramientas.reloadData()
        print("Pintando vista opciones de licenciaturas")
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
