//
//  ResultadosMateriaViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 20/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ResultadosMateriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var asignatura:String?
    var preguntasRealizadas:String?
    var resultadoFinal:String?
    
    @IBOutlet weak var mensajeResultados: UILabel!
    var fecha:String = ""
    
    var arrayDatos:[[String:AnyObject]] = []
    
    
    @IBOutlet weak var tablaResultados: UITableView!
    
    @IBOutlet weak var resultadosUno: UILabel!
    
    
    @IBOutlet weak var resultadosDos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultadosUno.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        resultadosDos.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
  
        
        mensajeResultados.text = "Obtuviste \(resultadoFinal!) de \(preguntasRealizadas!) preguntas"
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        fecha = formatter.string(from: date)
        
        print("asignatura \(asignatura!)")
        print("preguntasRealizadas \(preguntasRealizadas!)")
        print("resultadoFinal \(resultadoFinal!)")
        print("fecha \(fecha)")
        
        DataBase.checkAndCreateDatabase()
        
        let objDao = DataBase()
        objDao.ejecutarInsert("INSERT INTO materia(nombreModulo, totalPreguntas, fecha, aciertos) VALUES ('\(asignatura!)', '\(preguntasRealizadas!)', '\(fecha)', '\(resultadoFinal!)')")

        arrayDatos = objDao.ejecutarSelect("SELECT * FROM materia where nombreModulo='\(asignatura!)'") as! [[String : AnyObject]]
        
        // arrayDatos = objDao.ejecutarSelect("SELECT * FROM categorias") as! [[String : AnyObject]]
        
        //    concpetoIngreso = arrayDatos.firstObject as! [String]
        //   imagenes = arrayDatos.lastObject as! [String]
        
        print("categorias: \(arrayDatos.count)")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultados", for: indexPath)
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
