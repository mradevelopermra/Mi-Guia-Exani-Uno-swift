//
//  ResultadosDiagnosticoViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/6/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ResultadosDiagnosticoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var parametroCuestionario:String = ""
    
    @IBOutlet weak var tablaResultados: UITableView!
    
    var tipoHerramienta: [String] = []
    var tipoHerramientaorExamen: [String] = []
    
    var imagenesHerramienta: [String] = []
    var nombreHerramienta:String = ""
    
    var resultadosPorMateria:[Int] = []
    var arrayDatos:[[String:String]] = []
    var idModulo: [String] = []
    var preguntasExamen: [String] = []
    
    var contador:Int = 0
    var contadorMalas:Int = 0
    
     var arrayEscuelas:[[String:String]] = []

    
    @IBOutlet weak var diagExamenLeyenda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diagExamenLeyenda.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        
        
            idModulo = [
                "= 9",
                "IN(8, 2)",
                "= 1",
                "= 14",
                "= 12",
                "IN(10, 11)",
                "IN(4, 6)",
                "= 13"
            ]
            
            preguntasExamen = [
                "20",
                "20",
                "20",
                "20",
                "20",
                "20",
                "20",
                "20"
            ]
            
            tipoHerramienta = [
                "Pensamiento matemático",
                "Pensamiento analítico",
                "Estructura de la lengua",
                "Comprensión lectora",
                "Fenómenos biológicos y de la salud",
                "Fenómenos físico-químicos",
                "Comprensión del entorno de México",
                "Inglés"
            ]
        
        tipoHerramientaorExamen = Array<Any>(repeating: "", count: 4) as! [String]
            
            
            imagenesHerramienta = [
                "matematicasdos.png",
                "fisicafinal.png",
                "espanol.png",
                "razonamientoverbal.png",
                "biologia.png",
                "quimica.png",
                "historiademexico.png",
                "espanol.png"
            ]
            

        
        DataBase.checkAndCreateDatabase()
        
        let objDao = DataBase()
        
        
        //for i in 0  ..< arrayDatos.count  {
        
        var contadorMateria = 0;
            
            for k in 0  ..< idModulo.count  {
                
                contador = 0
                
                arrayDatos = objDao.ejecutarSelect("SELECT * FROM examenresultados where materia \(idModulo[k])") as! [[String : String]]
                
                
                
                if(arrayDatos.count>0){
                    print("idModulo \(idModulo[k])")
                    tipoHerramientaorExamen[contadorMateria] = tipoHerramienta[k]
                    contadorMateria = contadorMateria + 1
                    
                    
                    for i in 0  ..< arrayDatos.count  {
                        if(arrayDatos[i]["aciertos"] == "1"){
                            contador = contador + 1
                        }
                        if(arrayDatos[i]["aciertos"] == "0"){
                            contadorMalas = contadorMalas + 0
                        }
                    }

                    
                }
                
                if(arrayDatos.count>0){
                    if(contador>0){
                        resultadosPorMateria.append(contador)
                    }
                    if(contadorMalas==0 && contador==0){
                        resultadosPorMateria.append(contadorMalas)
                    }
                    
                    reloadTabla()
                    
                    print("resultadosPorMateria \(resultadosPorMateria)")
                    
                }


             /*   if(idModulo[k]=="1" && contador>6){
                    preguntasExamen.append("25 preguntas")
                }*/
                
            }

        //}

        if(arrayDatos.count<=0){
            diagExamenLeyenda.text = "No hay resultados, primero debes realizar tu examen simulacro."
            diagExamenLeyenda.font = UIFont(name: diagExamenLeyenda.font.fontName, size: 12)
            
        }else{
            diagExamenLeyenda.font = UIFont(name: diagExamenLeyenda.font.fontName, size: 17)
            
        }
        
        reloadTabla()
        
        print("resultadosPorMateria \(resultadosPorMateria)")
        //materia

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipoHerramientaorExamen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaResultados", for: indexPath) as! ResultadosDiagnosticoTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        let width = CGFloat(2.0)
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        let borderColor: UIColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        cell.layer.borderColor = borderColor.cgColor
        
        //color a los datos
        cell.textLabel?.textColor = borderColor
        
        let nombreMateria = tipoHerramientaorExamen[indexPath.row]
        
        var aciertos = ""
        
        if(resultadosPorMateria.count>0){
            aciertos = "Obtuviste: \(resultadosPorMateria[indexPath.row]) aciertos de \(preguntasExamen[indexPath.row]) preguntas"
        }
        
        
        
        // Configure the cell...
        let nombreCategoria = nombreMateria
        
        let imagen = imagenesHerramienta[indexPath.row]
        
            cell.imagenMateria?.image = UIImage(named: imagen as String)
            cell.nombreMateria?.numberOfLines = 0
            cell.nombreMateria?.text = nombreCategoria as String?
        
            cell.resultadoMateria?.numberOfLines = 0
            cell.resultadoMateria?.text = aciertos
        
        return cell
    }
    
    func reloadTabla(){
        self.tablaResultados.reloadData()
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
