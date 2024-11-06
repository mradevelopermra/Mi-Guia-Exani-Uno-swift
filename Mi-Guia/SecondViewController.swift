//
//  SecondViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 14/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController  {

    
    @IBOutlet weak var btncomenzar: UIButton!
    
    var arrayDatosPreguntas:[[String:String]] = []
    var arrayDatos:[[String:String]] = []
    
    var arrayRespuestas:[[String:String]] = []
    
    var arrayExamenAleatorio:[[String:String]] = []
    
    var arrayExamenAleatorioDiagnostico:[[String:String]] = []
    
    //consulta por materias
    var ConsultarExamenesRandomEspa:[[String:String]] = []
    var ConsultarExamenesRandomRazVerbal:[[String:String]] = []
    var ConsultarExamenesRandomHisUniv:[[String:String]] = []
    var ConsultarExamenesRandomHisMex:[[String:String]] = []
    var ConsultarExamenesRandomGeoUniv:[[String:String]] = []
    var ConsultarExamenesRandomGeoMex:[[String:String]] = []
    var ConsultarExamenesRandomCivismo:[[String:String]] = []
    var ConsultarExamenesRandomRazMate:[[String:String]] = []
    var ConsultarExamenesRandomMatematicas:[[String:String]] = []
    var ConsultarExamenesRandomFisica:[[String:String]] = []
    var ConsultarExamenesRandomQuimica:[[String:String]] = []
    var ConsultarExamenesRandomBiologia:[[String:String]] = []
    
    var arrayEscuelas:[[String:String]] = []
    
    
    @IBOutlet weak var instruccionesUno: UITextView!
    
    @IBOutlet weak var instruccionesDos: UITextView!
    
    
    @IBOutlet weak var btnLeyenda: UIButton!
    
    
    var tipoExamen = ""
    
    
    
    @IBAction func btnExaniAdmision(_ sender: Any) {
        examenAleatorioAreaUno()
    }
    
    
    @IBAction func btnExaniDiagnostico(_ sender: Any) {
        
        examenAleatorioAreaDos()
    }
    
    
    @IBOutlet weak var btnLeyendaBiagnostico: UIButton!
    
    var preguntasRealizadas:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        instruccionesUno.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        instruccionesDos.textColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        btnLeyenda.backgroundColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        btnLeyendaBiagnostico.backgroundColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        

        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        clasificacionExamen()
        respuestas()
        
        
        //examenAleatorioAreaUno()
        
        
        //self.pregunta()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clasificacionExamen()
        
    }
    
    func clasificacionExamen(){
        
        examenAleatorioAreaUno()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func examenAleatorioAreaUno(){
        
        tipoExamen = "Adminision"
        
        let objDaoIngresos = DataBase()
        
        self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        
        if(arrayDatos.count>0){
            self.ConsultarExamenesRandomEspa = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 9 ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            self.ConsultarExamenesRandomRazVerbal = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo IN(8, 2) ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisUniv = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 1 ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisMex = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 14 ORDER BY RANDOM() LIMIT 20") as! [[String : String]]


            
            arrayExamenAleatorio = ConsultarExamenesRandomEspa + ConsultarExamenesRandomRazVerbal + ConsultarExamenesRandomHisUniv + ConsultarExamenesRandomHisMex + ConsultarExamenesRandomGeoUniv
                + ConsultarExamenesRandomGeoMex + ConsultarExamenesRandomCivismo + ConsultarExamenesRandomRazMate
                + ConsultarExamenesRandomMatematicas + ConsultarExamenesRandomFisica + ConsultarExamenesRandomQuimica
                + ConsultarExamenesRandomBiologia
            
            print("arrayExamenAleatorio: \(self.arrayExamenAleatorio.count)")
            
            print("arrayDatos: \(self.arrayDatos.count)")
            
        }else{
            parsingWSAndSyncCategorias()
            
        }
        
    }
    
    func examenAleatorioAreaDos(){
        
        tipoExamen = "Diagnostico"
        
        let objDaoIngresos = DataBase()
        
        self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        if(arrayDatos.count>0){
            self.ConsultarExamenesRandomEspa = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 12 ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            self.ConsultarExamenesRandomRazVerbal = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo IN(10, 11)  ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisUniv = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo IN(4, 6)  ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisMex = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 13 ORDER BY RANDOM() LIMIT 20") as! [[String : String]]
            
            arrayExamenAleatorioDiagnostico = ConsultarExamenesRandomEspa + ConsultarExamenesRandomRazVerbal + ConsultarExamenesRandomHisUniv + ConsultarExamenesRandomHisMex + ConsultarExamenesRandomGeoUniv
                + ConsultarExamenesRandomGeoMex + ConsultarExamenesRandomCivismo + ConsultarExamenesRandomRazMate
                + ConsultarExamenesRandomMatematicas + ConsultarExamenesRandomFisica + ConsultarExamenesRandomQuimica
                + ConsultarExamenesRandomBiologia
            
            print("arrayExamenAleatorio: \(self.arrayExamenAleatorio.count)")
            
            print("arrayDatos: \(self.arrayDatos.count)")
            
        }
        
    }
    
    func examenAleatorioAreaTres(){
        
        let objDaoIngresos = DataBase()
        
        self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        if(arrayDatos.count>0){
            self.ConsultarExamenesRandomEspa = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 1 ORDER BY RANDOM() LIMIT 18") as! [[String : String]]
            
            self.ConsultarExamenesRandomRazVerbal = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 12 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisUniv = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 6 ORDER BY RANDOM() LIMIT 24") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisMex = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 7 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomGeoUniv = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 5 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomGeoMex = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 4 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomCivismo = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 11 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomRazMate = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 3 ORDER BY RANDOM() LIMIT 14") as! [[String : String]]
            
            self.ConsultarExamenesRandomMatematicas = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 8 ORDER BY RANDOM() LIMIT 14") as! [[String : String]]
            
            
            arrayExamenAleatorio = ConsultarExamenesRandomEspa + ConsultarExamenesRandomRazVerbal + ConsultarExamenesRandomHisUniv + ConsultarExamenesRandomHisMex + ConsultarExamenesRandomGeoUniv
                + ConsultarExamenesRandomGeoMex + ConsultarExamenesRandomCivismo + ConsultarExamenesRandomRazMate
                + ConsultarExamenesRandomMatematicas + ConsultarExamenesRandomFisica + ConsultarExamenesRandomQuimica
                + ConsultarExamenesRandomBiologia
            
            print("arrayExamenAleatorio: \(self.arrayExamenAleatorio.count)")
            
            print("arrayDatos: \(self.arrayDatos.count)")
            
        }
        
    }
    
    func examenAleatorioAreaCuatro(){
        
        let objDaoIngresos = DataBase()
        
        self.arrayDatos = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        if(arrayDatos.count>0){
            self.ConsultarExamenesRandomEspa = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 1 ORDER BY RANDOM() LIMIT 18") as! [[String : String]]
            
            self.ConsultarExamenesRandomRazVerbal = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 12 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisUniv = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 6 ORDER BY RANDOM() LIMIT 22") as! [[String : String]]
            
            self.ConsultarExamenesRandomHisMex = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 7 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomGeoUniv = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 5 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomGeoMex = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 4 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomCivismo = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 11 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomRazMate = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 3 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomMatematicas = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 8 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            self.ConsultarExamenesRandomBiologia = objDaoIngresos.ejecutarSelect("select * from tblpreguntasmodulo where idmodulo = 2 ORDER BY RANDOM() LIMIT 10") as! [[String : String]]
            
            
            arrayExamenAleatorio = ConsultarExamenesRandomEspa + ConsultarExamenesRandomRazVerbal + ConsultarExamenesRandomHisUniv + ConsultarExamenesRandomHisMex + ConsultarExamenesRandomGeoUniv
                + ConsultarExamenesRandomGeoMex + ConsultarExamenesRandomCivismo + ConsultarExamenesRandomRazMate
                + ConsultarExamenesRandomMatematicas + ConsultarExamenesRandomFisica + ConsultarExamenesRandomQuimica
                + ConsultarExamenesRandomBiologia
            
            print("arrayExamenAleatorio: \(self.arrayExamenAleatorio.count)")
            
            print("arrayDatos: \(self.arrayDatos.count)")
            
        }
        
    }
    
     var arrayPreguntas:[[String:String]] = []
    
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
    
    
    func respuestas(){
        
        let objDaoIngresos = DataBase()
        
        self.arrayRespuestas = objDaoIngresos.ejecutarSelect("SELECT * FROM tblpreguntasmodulo") as! [[String : String]]
        
        //print("arrayRespuestas \(arrayRespuestas)")
        
        var contadorCorrecta = 0
        var contadorOpcional = 0
        
        for k in 0 ..< arrayRespuestas.count{
            
            contadorOpcional = 0
            
            if(arrayRespuestas[k]["correcta"]!.trimmingCharacters(in: .whitespaces)==arrayRespuestas[k]["respuestauno"]!.trimmingCharacters(in: .whitespaces)){
                contadorCorrecta = contadorCorrecta + 1
                contadorOpcional = contadorOpcional + 1
            }
            if(arrayRespuestas[k]["correcta"]!.trimmingCharacters(in: .whitespaces)==arrayRespuestas[k]["respuestados"]!.trimmingCharacters(in: .whitespaces)){
                contadorCorrecta = contadorCorrecta + 1
                contadorOpcional = contadorOpcional + 1
            }
            if(arrayRespuestas[k]["correcta"]!.trimmingCharacters(in: .whitespaces)==arrayRespuestas[k]["respuestatres"]!.trimmingCharacters(in: .whitespaces)){
                contadorCorrecta = contadorCorrecta + 1
                contadorOpcional = contadorOpcional + 1
            }
            if(arrayRespuestas[k]["correcta"]!.trimmingCharacters(in: .whitespaces)==arrayRespuestas[k]["respuestacuatro"]!.trimmingCharacters(in: .whitespaces)){
                contadorCorrecta = contadorCorrecta + 1
                contadorOpcional = contadorOpcional + 1
            }
            
            if(contadorOpcional>1){
                print("contadorCorrecta \(contadorCorrecta)")
                print("pregunta \(arrayRespuestas[k]["pregunta"]!)")
                print("materia \(arrayRespuestas[k]["idmodulo"]!)")
                print("correcta \(arrayRespuestas[k]["correcta"]!)")
                 print("respuestados \(arrayRespuestas[k]["respuestados"]!)")
            }
            
            
            if(arrayRespuestas[k]["imagenpregunta"]!.contains(".PNG") || arrayRespuestas[k]["imagenpregunta"]!.contains(".png") ){
                
                print("imagenpregunta: \(arrayRespuestas[k]["imagenpregunta"]!)")
                
                let bundlePath = Bundle.main.path(forResource: arrayRespuestas[k]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
                
                let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
                
                let imageView = UIImageView(image: image)
                
                
            }
            
            
        }
        
        print("contadorCorrecta \(contadorCorrecta)")
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //clasificacionExamen()
        

        
        if segue.identifier == "examenDiagnostico"{

                let objVista2 = segue.destination as! ExamenViewController
                
                objVista2.arrayPreguntas = arrayExamenAleatorioDiagnostico

            
        }
        
            if segue.identifier == "verExamen"{
                    
                    let objVista2 = segue.destination as! ExamenViewController
                    
                    objVista2.arrayPreguntas = arrayExamenAleatorio

            }
            
    }


    //unwind
    @IBAction func volverVistaInfoExamen(unwindSegue: UIStoryboardSegue){
        print("Pintando vista escuelas")
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
    

}

