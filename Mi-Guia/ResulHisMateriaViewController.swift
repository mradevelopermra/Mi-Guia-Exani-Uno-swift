//
//  ResulHisMateriaViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 3/7/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ResulHisMateriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var tipoHerramienta: [String] = []
    var imagenesHerramienta: [String] = []
    
    var arrayDatos:[[String:AnyObject]] = []

    
    @IBOutlet weak var leyendaSelecciona: UILabel!
    
    
    @IBOutlet weak var tablaResultados: UITableView!
    
    var parametroCuestionario:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leyendaSelecciona.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        tipoHerramienta = [
            "Pensamiento matemático",
            "Pensamiento analítico",
            "Estructura de la lengua",
            "Comprensión lectora",
            "Fenómenos biológicos y de la salud",
            "Fenómenos físico-químicos",
            "Comprensión del entorno de México",
            "Inglés"
            // "Calculadora"
        ]
        
        
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
        
        //instanciar y definir dao
        
        let objDao = DataBase()
        
        arrayDatos = objDao.ejecutarSelect("SELECT * FROM materia where nombreModulo='\(tipoHerramienta[0])'") as! [[String : AnyObject]]

        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipoHerramienta.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Test"
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x: 0, y: 20, width: pickerView.bounds.width - 30, height: 80))
        
        myView.backgroundColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 25, width: 30, height: 30))
        
        var rowString = String()
        
        let myLabel = UILabel(frame: CGRect(x: 60, y: 0, width: pickerView.bounds.width - 90, height: 80 ))
        
        //  for i in 0  ..< concpetoIngreso.count  {
        
            rowString = tipoHerramienta[row]
            myImageView.image = UIImage(named:imagenesHerramienta[row])

        myLabel.textColor = UIColor.white
        myLabel.text = rowString
        
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        
        return myView
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedValue = pickerView.selectedRow(inComponent: 0)
        
        //inicia BD
        
        DataBase.checkAndCreateDatabase()
        
        //instanciar y definir dao
        
        let objDao = DataBase()
        
        
        for i in 0  ..< tipoHerramienta.count  {
            
            if(i == selectedValue){
                
                print("materia Seleccionada: \(tipoHerramienta[i])")

                        arrayDatos = objDao.ejecutarSelect("SELECT * FROM materia where nombreModulo='\(tipoHerramienta[i])'") as! [[String : AnyObject]]
            }
            
        }
        

    
        //montoTotal.text = "Monto total: \(String(montoCategoria))"
        self.tablaResultados.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayDatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultadoHistorico", for: indexPath)
        
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
        
        // Configure the cell...
        let fecha = arrayDatos[indexPath.row]["fecha"] as! String?
        let aciertos = arrayDatos[indexPath.row]["aciertos"] as! String?
        let totalPreguntas = arrayDatos[indexPath.row]["totalPreguntas"] as! String?
        
        let imagen = "an_ic_check_on.png"
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: 10, height: 10))
        myImageView.image = UIImage(named:imagen )
        
        
        cell.imageView?.image = myImageView.image
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = ("\(fecha!) Aciertos: \(aciertos!) Preguntas: \(totalPreguntas!)")
        
        
        return cell
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
