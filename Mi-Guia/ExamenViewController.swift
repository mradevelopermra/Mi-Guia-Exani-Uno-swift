//
//  ExamenViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 20/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class ExamenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrayPreguntas:[[String:String]] = []
    var arrayPregAct:[[String:String]] = []
    var arrayPregActPruebas:[[String:String]] = []
    var arrayRespuestas:[String] = []
    var correcta:String = ""
    var contadorCorrectas:Int = 0
    var respueta:String = ""
    var numPreguntas:String = ""
    var contador:Int = 0
    var imagenPreguntaMain:String = ""
    
    //variables preguntas
    var preguntaPreg:String = ""
    var preguntaImagen:String = ""
    var tooltip:String = ""
    var tooltipImagen:String = ""
    var materia:String = ""
    var fecha:String = ""
    var aciertos:String = ""
    
    var correctaIncorrecta:Int = 0
    
    var contadorExamen:Int = 1
    
    @IBOutlet weak var pregImageInstruccionesExamen: UITextView!
    
    @IBOutlet weak var preguntaMainPincipalExamen: UITextView!
    
    @IBOutlet weak var tablaAnswersExamen: UITableView!

    func reloadTabla(){
        self.tablaAnswersExamen.reloadData()
        self.preguntaMainPincipalExamen.becomeFirstResponder()
        self.pregImageInstruccionesExamen.becomeFirstResponder()
        self.pregImageInstruccionesExamen.resignFirstResponder()
        self.preguntaMainPincipalExamen.resignFirstResponder()
    }
    

    @IBAction func siguientePregunta(_ sender: Any) {
        if(respueta != ""){
            
            print("contador \(contador)")
            
            print("respuetanextCuestion \(respueta)")
            print("correctanextCuestion \(correcta)")
            
            if(respueta.trimmingCharacters(in: .whitespaces) == correcta.trimmingCharacters(in: .whitespaces)){
                contadorCorrectas = contadorCorrectas + 1
                correctaIncorrecta = 1
            }else{
                correctaIncorrecta = 0
            }
            print("contadorCorrectas \(contadorCorrectas)")
            let totalPreguntasInt = (numPreguntas as NSString).integerValue
            print("totalPreguntasInt \(totalPreguntasInt)")
            print("contador \(contador)")
            
            
            /*   arrayPregAct = DataBase().ejecutarSelect("SELECT * FROM examenresultados where id=\(contadorExamen)") as! [[String : String]]
             
             if(arrayPregAct.count>0){
             DataBase().ejecutarUpdate("UPDATE examenresultados SET pregunta = '\(preguntaPreg)', preguntaImagen = '\(preguntaImagen)', respuesta = '\(respueta)', correcta = '\(correcta)', tooltip = '\(tooltip)', tooltipImagen = '\(tooltipImagen)', materia = '\(materia)', fecha = '\(fecha)', aciertos = '\(correctaIncorrecta)' WHERE id = '\(contadorExamen)'")
             }else{*/
            DataBase().ejecutarInsert("INSERT INTO examenresultados (pregunta, preguntaImagen, respuesta, correcta, tooltip, tooltipImagen, materia, fecha, aciertos) VALUES ('\(preguntaPreg)', '\(preguntaImagen)', '\(respueta)', '\(correcta)', '\(tooltip)', '\(tooltipImagen)', '\(materia)', '\(fecha)', '\(correctaIncorrecta)')")
            //  }
            
            //  arrayPregActPruebas = DataBase().ejecutarSelect("SELECT * FROM examenresultados") as! [[String : String]]
            
            
            //   print("arrayPregActPruebas \(arrayPregActPruebas.count)")
            
            if(totalPreguntasInt == contador){
                self.performSegue(withIdentifier: "resEamen", sender: self)
            }else{
                contadorExamen = contadorExamen + 1
                contador = contador + 1
                
                tamanoPantallaYTooltippAcomoda = 0.0
                tamanoPantallaXTooltipp = 0.0
                pregunta()
                reloadTabla()
            }
            
        }else{
            
            // create the alert
            let alert = UIAlertController(title: "Atención", message: "¡Selecciona una respuesta!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    var arrayCompras:[[String:String]] = []
    
    var tamanoPantallaXTooltipp: CGFloat!
    var tamanoPantallaYTooltipp: CGFloat!
    var tamanoPantallaYTooltippAcomoda: CGFloat!
    
    
    @IBOutlet weak var scrollExamen: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tamanoPantallaXTooltipp = self.view.frame.size.width
        tamanoPantallaYTooltipp = self.view.frame.size.height
        tamanoPantallaYTooltippAcomoda = 60.0
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        numPreguntas = "79"
        
        print("arrayPreguntas: \(arrayPreguntas.count)")
        
        print("ULTIMA CORRECTA: \(arrayPreguntas[79]["pregunta"]!)")
        
        DataBase().ejecutarDelete("DELETE FROM examenresultados")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        fecha = formatter.string(from: date)
        
        tablaAnswersExamen.rowHeight = UITableViewAutomaticDimension
        tablaAnswersExamen.estimatedRowHeight = 140
        
        //pregunta()
        
        pregImageInstruccionesExamen.isScrollEnabled = true
        preguntaMainPincipalExamen.isScrollEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pregunta()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUncachedImage (named name : String) -> UIImage?
    {
        if let imgPath = Bundle.main.path(forResource: name, ofType: nil)
        {
            return UIImage(contentsOfFile: imgPath)
        }
        return nil
    }

    
  func pregunta(){
        //     for i in 0  ..< arrayPreguntas.count  {
        //    print("i: \(i)")
    
    //imagenPreguntaMain:  )
        //print("arrayPreguntas \(arrayPreguntas)")
    
   /* var contador = 0;
    var contadorPREGUNTA = 1;
    
    for i in 0..<arrayPreguntas.count{
        print("contadorPREGUNTA \(contadorPREGUNTA)")
        if(arrayPreguntas[i]["correcta"]!.trimmingCharacters(in: .whitespaces).elementsEqual(arrayPreguntas[i]["respuestauno"]!.trimmingCharacters(in: .whitespaces))){
            print("respuestauno \(arrayPreguntas[i]["respuestauno"]!.trimmingCharacters(in: .whitespaces))")
            contador = contador + 1
            print("contador \(contador)")
        }
        if(arrayPreguntas[i]["correcta"]!.trimmingCharacters(in: .whitespaces).elementsEqual(arrayPreguntas[i]["respuestados"]!.trimmingCharacters(in: .whitespaces))){
            print("respuestados \(arrayPreguntas[i]["respuestados"]!.trimmingCharacters(in: .whitespaces))")
            contador = contador + 1
            print("contador \(contador)")
        }
        if(arrayPreguntas[i]["correcta"]!.trimmingCharacters(in: .whitespaces).elementsEqual(arrayPreguntas[i]["respuestatres"]!.trimmingCharacters(in: .whitespaces))){
            print("respuestatres \(arrayPreguntas[i]["respuestatres"]!.trimmingCharacters(in: .whitespaces))")
            contador = contador + 1
            print("contador \(contador)")
        }
        if(arrayPreguntas[i]["correcta"]!.trimmingCharacters(in: .whitespaces).elementsEqual(arrayPreguntas[i]["respuestacuatro"]!.trimmingCharacters(in: .whitespaces))){
            print("respuestacuatro \(arrayPreguntas[i]["respuestacuatro"]!.trimmingCharacters(in: .whitespaces))")
            contador = contador + 1
            print("contador \(contador)")
        }
        contadorPREGUNTA = contadorPREGUNTA + 1
    }
    
    print("contadorFinal \(contador)")*/
    
    
    tamanoPantallaXTooltipp = self.view.frame.size.width
    tamanoPantallaYTooltipp = self.view.frame.size.height
    
    tamanoPantallaYTooltippAcomoda = 50.0
    
    respueta = ""
    correcta = arrayPreguntas[contador]["correcta"]!
    
    preguntaPreg = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
    preguntaImagen = arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces)

    tooltip = arrayPreguntas[contador]["tooltip"]!.trimmingCharacters(in: .whitespaces)
    tooltipImagen = arrayPreguntas[contador]["imagentooltip"]!.trimmingCharacters(in: .whitespaces)
    materia = arrayPreguntas[contador]["idmodulo"]!.trimmingCharacters(in: .whitespaces)

    
    preguntaMainPincipalExamen.isScrollEnabled = false
    pregImageInstruccionesExamen.isScrollEnabled = false
    
    self.preguntaMainPincipalExamen.font = .systemFont(ofSize: 20)
    self.pregImageInstruccionesExamen.font = .systemFont(ofSize: 20)
    
    if(arrayPreguntas[contador]["imagenpregunta"]! == ""){
        
        
        preguntaMainPincipalExamen.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0, height: tamanoPantallaYTooltipp)
        
        preguntaMainPincipalExamen.text = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
        pregImageInstruccionesExamen.text = ""
        
        preguntaMainPincipalExamen.isScrollEnabled = false
        
        preguntaMainPincipalExamen.translatesAutoresizingMaskIntoConstraints = true
        preguntaMainPincipalExamen.sizeToFit()
        preguntaMainPincipalExamen.isEditable = false
        preguntaMainPincipalExamen.isSelectable = false
        
        let fixedWidth = preguntaMainPincipalExamen.frame.size.width
        
        let newSize = preguntaMainPincipalExamen.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        preguntaMainPincipalExamen.frame.size = CGSize(width: tamanoPantallaXTooltipp - 10.0, height: newSize.height)
        
        scrollExamen.addSubview(preguntaMainPincipalExamen)
        
        //self.view.addSubview(scrollView)
        
        tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + scrollExamen.frame.size.height + 100.0
        
        pregImageInstruccionesExamen.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: 10.0)
        
        scrollExamen.addSubview(pregImageInstruccionesExamen)
        
        

    }else{
        
        print("imagenPreguntaMain: \(arrayPreguntas[contador]["imagenpregunta"]!)")
        
        var image: UIImage!
        var imageView: UIImageView!
        
        image = nil
        imageView = nil
        imagenPreguntaMain = ""
      //  let tipoImagen = String(arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces).suffix(4))
        
        let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
        
        imagenPreguntaMain = arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces)
        
        image = UIImage(contentsOfFile: bundlePath!)
        
        imageView = UIImageView(image: image)
        
        
        
        imageView.image = UIImage(contentsOfFile: bundlePath!)
        
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: "")
        
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(contentsOfFile: bundlePath!)
        
        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        //fullString.append(NSAttributedString(string: "End of text"))
        
        // draw the result in a label
        self.preguntaMainPincipalExamen.attributedText = fullString
        
        var frame = self.preguntaMainPincipalExamen.frame
        frame.size.height = self.preguntaMainPincipalExamen.contentSize.height
        self.preguntaMainPincipalExamen.frame = frame
        
        pregImageInstruccionesExamen.text = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
        
        pregImageInstruccionesExamen.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: tamanoPantallaYTooltipp)
        
        pregImageInstruccionesExamen.isScrollEnabled = false
        
        pregImageInstruccionesExamen.translatesAutoresizingMaskIntoConstraints = true
        pregImageInstruccionesExamen.sizeToFit()
        pregImageInstruccionesExamen.isEditable = false
        pregImageInstruccionesExamen.isSelectable = false
        
        let fixedWidth = pregImageInstruccionesExamen.frame.size.width
        
        let newSize = pregImageInstruccionesExamen.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        pregImageInstruccionesExamen.frame.size = CGSize(width: tamanoPantallaXTooltipp - 20.0, height: newSize.height)
        
        scrollExamen.addSubview(pregImageInstruccionesExamen)            //self.view.addSubview(scrollView)
        
        tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + pregImageInstruccionesExamen.frame.size.height + 30.0
        
        preguntaMainPincipalExamen.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: tamanoPantallaYTooltipp)
        
        preguntaMainPincipalExamen.isScrollEnabled = false
        
        preguntaMainPincipalExamen.translatesAutoresizingMaskIntoConstraints = true
        preguntaMainPincipalExamen.sizeToFit()
        preguntaMainPincipalExamen.isEditable = false
        preguntaMainPincipalExamen.isSelectable = false
        
        let fixedWidthPreg = preguntaMainPincipalExamen.frame.size.width
        
        let newSizePreg = preguntaMainPincipalExamen.sizeThatFits(CGSize(width: fixedWidthPreg, height: CGFloat.greatestFiniteMagnitude))
        
        preguntaMainPincipalExamen.frame.size = CGSize(width: tamanoPantallaXTooltipp, height: newSizePreg.height)
        
        scrollExamen.addSubview(preguntaMainPincipalExamen)
        
        //self.view.addSubview(scrollView)
        
        tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + pregImageInstruccionesExamen.frame.size.height + 100.0
        

    }
    
    
    let fixedWidthPreg = tablaAnswersExamen.frame.size.width
    
    let newSizePreg = tablaAnswersExamen.sizeThatFits(CGSize(width: fixedWidthPreg, height: CGFloat.greatestFiniteMagnitude))
    
    tablaAnswersExamen.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: 0.0, height: 0.0)
    
    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + tablaAnswersExamen.frame.size.height + 100.0
    
    tablaAnswersExamen.frame.size = CGSize(width: tamanoPantallaXTooltipp, height: newSizePreg.height)
    
    tablaAnswersExamen.translatesAutoresizingMaskIntoConstraints = false
    tablaAnswersExamen.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
    tablaAnswersExamen.sizeToFit()
    
    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + tablaAnswersExamen.frame.height + 50.0
    
    scrollExamen.addSubview(tablaAnswersExamen)
    
    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + tablaAnswersExamen.frame.height + 50.0
    
    scrollExamen.addSubview(tablaAnswersExamen)
    
    scrollExamen.contentSize = CGSize(width: tamanoPantallaXTooltipp, height: tamanoPantallaYTooltippAcomoda)
    
    print("scrollExamen \(scrollExamen.contentSize.height)")
    
    self.view.addSubview(scrollExamen)
    
    
    

    
    
        arrayRespuestas = []
        if(arrayPreguntas[contador]["respuestauno"]! != ""){
            arrayRespuestas.append(arrayPreguntas[contador]["respuestauno"]!)
        }
        if(arrayPreguntas[contador]["respuestados"]! != ""){
            arrayRespuestas.append(arrayPreguntas[contador]["respuestados"]!)
        }
        if(arrayPreguntas[contador]["respuestatres"]! != ""){
            arrayRespuestas.append(arrayPreguntas[contador]["respuestatres"]!)
        }
        if(arrayPreguntas[contador]["respuestacuatro"]! != ""){
            arrayRespuestas.append(arrayPreguntas[contador]["respuestacuatro"]!)
        }
        
        
        //  }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRespuestas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "radioPreguntasExamen", for: indexPath)
        
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
        let nombreCategoria = arrayRespuestas[indexPath.row].trimmingCharacters(in: .whitespaces)
        
       // let tipoImagen = String(arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces).suffix(4))
        
        let bundlePath = Bundle.main.path(forResource: arrayRespuestas[indexPath.row].trimmingCharacters(in: .whitespaces), ofType: nil)
        
        let imagen = "an_ic_radiobutton_off.png"
        
        let bundlePathRadio = Bundle.main.path(forResource:imagen, ofType: nil)
        
        //print("bundlePathRadio \(bundlePathRadio!)")
        
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: 30, height: 30))
        myImageView.image = UIImage(contentsOfFile: bundlePathRadio! )
        
        if(nombreCategoria.contains(".PNG") || nombreCategoria.contains(".png") ){
            print("imagenRespuestas \(nombreCategoria)")
            cell.imageView?.image = myImageView.image
            
            // create an NSMutableAttributedString that we'll append everything to
            let fullString = NSMutableAttributedString(string: "")
            
            // create our NSTextAttachment
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(contentsOfFile: bundlePath! )
            
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            
            // add the NSTextAttachment wrapper to our full string, then add some more text.
            fullString.append(image1String)
            //fullString.append(NSAttributedString(string: "End of text"))
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.attributedText = fullString
            
        }else{
            
            let imagen = "an_ic_radiobutton_off.png"
            
            let bundlePathRadio = Bundle.main.path(forResource:imagen, ofType: nil)
            
            //print("bundlePathRadio \(bundlePathRadio!)")
            
            let myImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: 30, height: 30))
            
            myImageView.image = UIImage(contentsOfFile: bundlePathRadio! )
            cell.imageView?.image = myImageView.image
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = nombreCategoria as String?
        }
        
        return cell
    }
    
  /*  func reloadTabla(){
        self.tablaRespuestasExamen.reloadData()
    }*/
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   let cell = tableView.dequeueReusableCell(withIdentifier: "cellcuestionario", for: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        var imagen = ""
        
 
        //reloadTabla()
        
        let fila = indexPath
        print("fila \(fila.row)")
        
        
        imagen = "an_ic_radiobutton_on.png"
        
        let bundlePathRadio = Bundle.main.path(forResource:imagen, ofType: nil)
        
        //print("bundlePathRadio \(bundlePathRadio!)")
        
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: 30, height: 30))
        myImageView.image = UIImage(contentsOfFile: bundlePathRadio! )
        
        cell?.imageView?.image = myImageView.image
        
        respueta = arrayRespuestas[indexPath.row]
        print("respuetaElegida: \(respueta)")
        
        
        
        /* if let _ = tableView.cellForRow(at: indexPath) {
         if nombreHerramienta == "Razonamiento verbal" {
         datoRecibido = nombreHerramienta
         performSegue(withIdentifier: "cuestionario",
         sender: self)
         }
         
         }*/
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var imagen = ""
        
        imagen = "an_ic_radiobutton_off.png"
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: 30, height: 30))
        myImageView.image = UIImage(named: imagen )
        
        cell?.imageView?.image = myImageView.image
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resEamen"{
            let correctasFinalTotal = "\(contadorCorrectas)"
            let objVista2 = segue.destination as! ResulExamenViewController
            numPreguntas = "80"
            objVista2.preguntasRealizadas = numPreguntas
            objVista2.resultadoFinal = correctasFinalTotal
        }
        
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
