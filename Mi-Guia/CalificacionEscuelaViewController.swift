//
//  CalificacionEscuelaViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/6/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class CalificacionEscuelaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayDatos:[[String:String]] = []
    var arrayResultados:[[String:String]] = []
    
    var arrayEscuelas:[String] = [
        "Selecciona una escuela",
        "Actuaria Ciudad Universitaria",
        "Actuaria FES Acatlán",
        "Arquitectura Ciudad Universitaria",
        "Arquitectura FES Aragón",
        "Arquitectura FES Acatlán",
        "Arquitectura del Paisaje Ciudad Universitaria",
        "Ciencia de Materiales Sustentables Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Ciencias de la Computación Ciudad Universitaria",
        "Ciencias de la Tierra Ciudad Universitaria",
        "Ciencias de la Tierra UMDI, Juriquilla, Qro",
        "Diseño Industrial FES Aragón",
        "Física Ciudad Universitaria",
        "Física Biomédica Ciudad Universitaria",
        "Geociencias Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Ingeniería Cívil Ciudad Universitaria",
        "Ingeniería Cívil FES Aragón",
        "Ingeniería Cívil FES Acatlán",
        "Ingeniería de Eléctrica - Electrónica Ciudad Universitaria",
        "Ingeniería de Eléctrica - Electrónica FES Aragón",
        "Ingeniería de Minas y Metalurgia Ciudad Universitaria",
        "Ingeniería en Computación Ciudad Universitaria",
        "Ingeniería en Computación FES Aragón",
        "Ingeniería en Telecomunicaciones Sistemas y Electrónica FES Cuautitlán",
        "Ingeniería Geofísica Ciudad Universitaria",
        "Ingeniería Geológica Ciudad Universitaria",
        "Ingeniería Geomática Ciudad Universitaria",
        "Ingeniería Industrial Ciudad Universitaria",
        "Ingeniería Industrial FES Aragón",
        "Ingeniería Industrial FES Cuautitlán",
        "Ingeniería Mecánica Ciudad Universitaria",
        "Ingeniería Mecánica FES Aragón",
        "Ingeniería Mecánica Eléctrica FES Cuautitlán",
        "Ingeniería Petrolera Ciudad Universitaria",
        "Ingeniería Química Ciudad Universitaria",
        "Ingeniería Química FES Cuautitlán",
        "Ingeniería Química FES Zaragoza",
        "Ingeniería Química Metalúrgica Ciudad Universitaria",
        "Matemáticas Ciudad Universitaria",
        "Matemáticas Aplicadas Ciudad Universitaria",
        "Matemáticas Aplicadas y Computación FES Acatlán",
        "Tecnologías para la Información en Ciencias Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Biología Ciudad Universitaria",
        "Biología FES Zaragoza",
        "Biología FES Iztacala",
        "Biología Tlaxcala",
        "Bioquímica Diagnóstica FES Cuautitlán",
        "Ciencias Ambientales Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Cirujano Dentista Ciudad Universitaria",
        "Cirujano Dentista FES Zaragoza",
        "Cirujano Dentista FES Iztacala",
        "Enfermería FES Zaragoza",
        "Enfermería FES Iztacala",
        "Enfermería Escuela Nacional De Enfermería y Obstetricia",
        "Enfermería Tlaxcala",
        "Enfermería y Obstetricia Escuela Nacional De Enfermería y Obstetricia",
        "Farmacia FES Cuautitlán",
        "Físioterapia Escuela Nacional de Estudios Superiores, Unidad León",
        "Ingeniería Agrícola FES Cuautitlán",
        "Ingeniería en Alimentos FES Cuautitlán",
        "Medicina Veterinaria y Zootecnia Ciudad Universitaria",
        "Medicina Veterinaria y Zootecnia FES Cuautitlán",
        "Medico Cirujano Ciudad Universitaria",
        "Medico Cirujano FES Zaragoza",
        "Medico Cirujano FES Iztacala",
        "Odontología Escuela Nacional de Estudios Superiores, Unidad León",
        "Optometría FES Iztacala",
        "Optometría Escuela Nacional de Estudios Superiores, Unidad León",
        "Psicología Ciudad Universitaria",
        "Psicología FES Zaragoza",
        "Psicología FES Iztacala",
        "Psicología Modalidad Abierta Ciudad Universitaria",
        "Psicología Modalidad A Distancia",
        "Psicología Tlaxcala",
        "Química Ciudad Universitaria",
        "Química FES Cuautitlán",
        "Química de Alimentos Ciudad Universitaria",
        "Química Farmacéutico Biológica Ciudad Universitaria",
        "Química Farmacéutico Biológica FES Zaragoza",
        "Química Industrial FES Cuautitlán",
        "Administración Ciudad Universitaria",
        "Administración FES Cuautitlán",
        "Administración Modalidad Abierta Ciudad Universitaria",
        "Administración Modalidad A Distancia",
        "Administración Agropecuaria Escuela Nacional de Estudios Superiores, Unidad León",
        "Antropología Ciudad Universitaria",
        "Ciencias de la Comunicación Ciudad Universitaria",
        "Ciencias de la Comunicación Modalidad Abierta Ciudad Universitaria",
        "Ciencias de la Comunicación (Periodismo) Modalidad A Distancia",
        "Ciencias Políticas y Administración Pública Ciudad Universitaria",
        "Ciencias Políticas y Administración Pública FES Acatlán",
        "Ciencias Políticas y Administración Pública Modalidad Abierta Ciudad Universitaria",
        "Ciencias Políticas y Administración Pública Modalidad A Distancia",
        "Comunicación FES Acatlán",
        "Comunicación y Periodismo FES Aragón",
        "Contaduría Ciudad Universitaria",
        "Contaduría FES Cuautitlán",
        "Contaduría Modalidad Abierta Ciudad Universitaria",
        "Contaduría Modalidad A Distancia",
        "Derecho Ciudad Universitaria",
        "Derecho FES Aragón",
        "Derecho FES Acatlán",
        "Derecho Modalidad Abierta Acatlán",
        "Derecho Modalidad Abierta Ciudad Universitaria",
        "Derecho Modalidad Abierta Aragón",
        "Derecho Modalidad A Distancia",
        "Desarrollo Comunitario para el Envejecimiento Tlaxcala",
        "Desarrollo Territorial Escuela Nacional de Estudios Superiores, Unidad León",
        "Economía Ciudad Universitaria",
        "Economía FES Aragón",
        "Economía FES Acatlán",
        "Economía Modalidad Abierta Ciudad Universitaria",
        "Economía Modalidad Abierta Aragón",
        "Economía Modalidad A Distancia",
        "Economía Industrial Escuela Nacional de Estudios Superiores, Unidad León",
        "Estudios Sociales y Gestión Local Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Geografía Ciudad Universitaria",
        "Geografía Modalidad Abierta Ciudad Universitaria",
        "Informática FES Cuautitlán",
        "Planif. para el Desarrollo Agropecuario FES Aragón",
        "Relaciones Internacionales Ciudad Universitaria",
        "Relaciones Internacionales FES Aragón",
        "Relaciones Internacionales FES Acatlán",
        "Relaciones Internacionales Modalidad Abierta Acatlán",
        "Relaciones Internacionales Modalidad Abierta Ciudad Universitaria",
        "Relaciones Internacionales Modalidad Abierta Aragón",
        "Relaciones Internacionales Modalidad A Distancia",
        "Sociología Ciudad Universitaria",
        "Sociología FES Aragón",
        "Sociología FES Acatlán",
        "Sociología Modalidad Abierta Ciudad Universitaria",
        "Sociología Modalidad A Distancia",
        "Trabajo Social Modalidad A Distancia",
        "Trabajo Social Escuela Nacional de Trabajo Social",
        "Administración de Archivos y Gestión Documental Ciudad Universitaria",
        "Administración de Archivos y Gestión Documental Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Artes Visuales Facultad de Artes y Diseño",
        "Artes Visuales Plantel Taxco, GRO",
        "Arte y Diseño Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Arte y Diseño Plantel Taxco, GRO",
        "Bibliotecologia y Estudios de la Información Ciudad Universitaria",
        "Bibliotecologia y Estudios de la Información Modalidad A Distancia",
        "Canto Escuela Nacional de Música",
        "Composición Escuela Nacional de Música",
        "Desarrollo y Gestión Interculturales Ciudad Universitaria",
        "Desarrollo y Gestión Interculturales Escuela Nacional de Estudios Superiores, Unidad León",
        "Desarrollo y Gestión Interculturales Centro Peninsular en Humanidades y Ciencias Sociales",
        "Diseño Gráfico FES Acatlán",
        "Diseño y Comunicación Visual FES Cuautitlán",
        "Diseño y Comunicación Visual Modalidad A Distancia",
        "Diseño y Comunicación Visual Facultad de Artes y Diseño",
        "Educación Musical Escuela Nacional de Música",
        "Enseñanza de Alemán como Lengua Extranjera Modalidad A Distancia",
        "Enseñanza de Español como Lengua Extranjera Modalidad A Distancia",
        "Enseñanza de Francés como Lengua Extranjera Modalidad A Distancia",
        "Enseñanza de Inglés FES Acatlán",
        "Enseñanza de Inglés como Lengua Extranjera Modalidad A Distancia",
        "Enseñanza de Italiano como Lengua Extranjera Modalidad A Distancia",
        "Estudios Latinoamericanos Ciudad Universitaria",
        "Etnomusicología Escuela Nacional de Música",
        "Filosofía Ciudad Universitaria",
        "Filosofía FES Acatlán",
        "Filosofía Modalidad Abierta Ciudad Universitaria",
        "GeoHistoria Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Historia Ciudad Universitaria",
        "Historia FES Acatlán",
        "Historia Modalidad Abierta Ciudad Universitaria",
        "Historia del Arte Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Instrumentista Escuela Nacional de Música",
        "Lengua y Literaturas Hispánicas Ciudad Universitaria",
        "Lengua y Literaturas Hispánicas FES Acatlán",
        "Lengua y Literaturas Hispánicas Modalidad Abierta Ciudad Universitaria",
        "Lengua y Literaturas Modernas (Letras Alemanas) Ciudad Universitaria",
        "Lengua y Literaturas Modernas (Letras Francesas) Ciudad Universitaria",
        "Lengua y Literaturas Modernas (Letras Inglesas) Ciudad Universitaria",
        "Lengua y Literaturas Modernas (Letras Inglesas) Modalidad Abierta Ciudad Universitaria",
        "Lengua y Literaturas Modernas (Letras Italianas) Ciudad Universitaria",
        "Lengua y Literaturas Modernas (Letras Portuguesas) Ciudad Universitaria",
        "Letras Clásicas Ciudad Universitaria",
        "Lingüistica aplicada Ciudad Universitaria",
        "Literatura Dramática y Teatro Ciudad Universitaria",
        "Literatura Intercultural Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Música y Tecnología Artística Escuela Nacional de Estudios Superiores, Unidad Morelia",
        "Nutriología FES Zaragoza",
        "Pedagogía Ciudad Universitaria",
        "Pedagogía FES Aragón",
        "Pedagogía FES Acatlán",
        "Pedagogía Modalidad Abierta Ciudad Universitaria",
        "Pedagogía Modalidad A Distancia",
        "Piano Escuela Nacional de Música",
        "Traducción Ciudad Universitaria"
    ]
    
    
    var arrayImagenEscuela:[String] =  [
        "",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png",
        "unam.png"
    ]
    
    var contador:Int = 0
    
    var parametroCuestionario:String = ""
    
    
    @IBOutlet weak var calificacionEscuelaLeyenda: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calificacionEscuelaLeyenda.textColor = UIColor(red:0.03, green:0.08, blue:0.39, alpha:1.0)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.03, green:0.08, blue:0.39, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]

        refresh()
        // Do any additional setup after loading the view.
    }
    
    
    func refresh(){
        
        //self.refreshControl.endRefreshing()
        
        let objDaoIngresos = DataBase()
        
        arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM opcionesescuelas") as! [[String : String]]
        
        arrayResultados = objDaoIngresos.ejecutarSelect("SELECT * FROM examenresultados") as! [[String : String]]
        
        for i in 0  ..< arrayResultados.count  {
            
            if(arrayResultados[i]["aciertos"] == "1"){
                contador = contador + 1
            }
            
        }
        
        print("arrayDatos \(arrayDatos)")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "califescuelas", for: indexPath) as! CalificacionEscuelaTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        let width = CGFloat(2.0)
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.frame = CGRect(x: 0, y: cell.frame.size.height - width, width:  cell.frame.size.width, height: cell.frame.size.height)
        let borderColor: UIColor = UIColor(red:0.00, green:0.43, blue:0.76, alpha:1.0)
        cell.layer.borderColor = borderColor.cgColor
        
        //color a los datos
        //cell.textLabel?.textColor = borderColor
        
        let nombreMateria = arrayDatos[indexPath.row]["escuelalicenciatura"]
        let puntaje = "Para esta licenciatura requieres: \(arrayDatos[indexPath.row]["aciertos"]!) puntos"
        let puntajeObtenido = "Obtuviste \(contador) aciertos"
        
        var imagen = ""
        
        for i in 0  ..< arrayEscuelas.count  {
            if(arrayEscuelas[i] == nombreMateria){
                imagen = arrayImagenEscuela[i]
            }
        }
        
        // Configure the cell...
        let nombreCategoria = nombreMateria
        
        
        
        cell.imagenEscuela?.image = UIImage(named: imagen as String)
        
        cell.escuelaCarrera?.text = nombreCategoria as String?
        cell.escuelaCarrera?.sizeToFit()
        cell.escuelaCarrera?.numberOfLines = 0
        cell.escuelaCarrera?.adjustsFontSizeToFitWidth = true
        cell.escuelaCarrera?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.aciertosEscuela?.text = puntaje
        cell.aciertosEscuela?.sizeToFit()
        cell.aciertosEscuela?.numberOfLines = 0
        cell.aciertosEscuela?.adjustsFontSizeToFitWidth = true
        cell.aciertosEscuela?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell.puntajeObtenido?.text = puntajeObtenido
        cell.puntajeObtenido?.sizeToFit()
        cell.puntajeObtenido?.numberOfLines = 0
        cell.puntajeObtenido?.adjustsFontSizeToFitWidth = true
        cell.puntajeObtenido?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
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
