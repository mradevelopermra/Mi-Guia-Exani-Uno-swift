//
//  PreguntasModuloViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 19/05/18.
//  Copyright © 2018 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class PreguntasModuloViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var materia:String?
    var numPreguntas:String?
    var ayuda:String?
    var arrayPreguntas:[[String:String]] = []
    var arrayRespuestas:[String] = []
    var contador:Int=0
    var tooltipVar:String=""
    var preguntaPrincVar:String=""
    var imagenTooltip:String = ""
    var tooltip:String = ""
    var respueta:String = ""
    var imagenPreguntaMain:String = ""
    var prueba:Int=0
    var correcta:String = ""
    var contadorCorrectas:Int = 0
    var imagenSiNo:Bool = false

    @IBOutlet weak var pregImageInstrucciones: UITextView!
    @IBOutlet weak var preguntaMainPincipal: UITextView!
    
    
    @IBOutlet weak var tablaAnswers: UITableView!
    

    
    var soloCierra = "No"
    
    @IBAction func tip(_ sender: Any) {
        soloCierra = "Si"
        correctaTootlipModal.text = "Tip de estudio"
        tooltipModal.text = tooltip
        self.tooltipModal.font = .systemFont(ofSize: 20)
        self.correctaTootlipModal.font = .systemFont(ofSize: 20)
        // mensajeTooltip.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mensajeTooltip.center = view.center
        self.view.addSubview(mensajeTooltip)
    }
    //modalTooltip inicio
    @IBOutlet weak var correctaTootlipModal: UITextView!
    
    @IBOutlet weak var tooltipModal: UITextView!
    
    @IBAction func cerrarTooltipModal(_ sender: Any) {
        
        let totalPreguntasInt = (numPreguntas! as NSString).integerValue - 1
        print("totalPreguntasInt \(totalPreguntasInt)")
        print("contador \(contador)")
        
        if(respueta==""){
            
            if(soloCierra == "Si"){
                self.mensajeTooltip.removeFromSuperview()
            }else{
                
            }

        }else{
            if(soloCierra == "Si"){
                self.mensajeTooltip.removeFromSuperview()
            }else{
                if(totalPreguntasInt == contador){
                    self.performSegue(withIdentifier: "muestraResultados", sender: self)
                }else{
                    contador = contador + 1
                    pregunta()
                    reloadTabla()
                }
                self.mensajeTooltip.removeFromSuperview()
            }
        }

        
    }
    @IBOutlet var mensajeTooltip: UIView!
    

    //modalTooltip fin
    
    
    @IBOutlet weak var tituloMateria: UINavigationItem!
    
    
    @IBOutlet weak var botonTooltip: UIButton!
    
    
    
    @IBOutlet weak var btnTooltipLeyenda: UIButton!
    
    
    @IBAction func siguientePregunta(_ sender: Any) {
        soloCierra = "No"
        if(respueta != ""){
            print("respuetanextCuestion \(respueta)")
            print("correctanextCuestion \(correcta)")
            
            if(respueta.trimmingCharacters(in: .whitespaces) == correcta.trimmingCharacters(in: .whitespaces)){
                contadorCorrectas = contadorCorrectas + 1
                
                tooltipModal.text = "Has logrado: \(contadorCorrectas) aciertos"
                
                // create an NSMutableAttributedString that we'll append everything to
                let fullString = NSMutableAttributedString(string: "¡Respuesta Correcta!      ")
                
                let imagen = "an_ic_check_on.png"
                
                let bundlePathCheck = Bundle.main.path(forResource:imagen, ofType: nil)
                
                // create our NSTextAttachment
                let image1Attachment = NSTextAttachment()
                image1Attachment.image = UIImage(contentsOfFile: bundlePathCheck!)
                
                // wrap the attachment in its own attributed string so we can append it
                let image1String = NSAttributedString(attachment: image1Attachment)
                
                // add the NSTextAttachment wrapper to our full string, then add some more text.
                fullString.append(image1String)
                //fullString.append(NSAttributedString(string: "End of text"))
                
                // draw the result in a label
                self.correctaTootlipModal.attributedText = fullString
                
                var frame = self.correctaTootlipModal.frame
                frame.size.height = self.correctaTootlipModal.contentSize.height
                self.correctaTootlipModal.frame = frame
                
                
                mensajeTooltip.center = view.center
                self.view.addSubview(mensajeTooltip)
                
            }else{
                
                print("imagenTooltip: \(imagenTooltip)")
                
                print("correcta: \(correcta)")
                
                
                
                if(imagenTooltip.contains(".PNG") || imagenTooltip.contains(".png")){
                    // create an NSMutableAttributedString that we'll append everything to
                    let fullString = NSMutableAttributedString(string: tooltip + "\n\n")
                    
                    
                    let bundlePathTooltip = Bundle.main.path(forResource:imagenTooltip, ofType: nil)
                    
                    // create our NSTextAttachment
                    let image1Attachment = NSTextAttachment()
                    image1Attachment.image = UIImage(contentsOfFile: bundlePathTooltip!)
                    
                    // wrap the attachment in its own attributed string so we can append it
                    let image1String = NSAttributedString(attachment: image1Attachment)
                    
                    // add the NSTextAttachment wrapper to our full string, then add some more text.
                    fullString.append(image1String)
                    //fullString.append(NSAttributedString(string: "End of text"))
                    
                    // draw the result in a label
                    self.tooltipModal.attributedText = fullString
                    
                    var frame = self.tooltipModal.frame
                    frame.size.height = self.tooltipModal.contentSize.height
                    self.tooltipModal.frame = frame
                   
                     self.tooltipModal.font = .systemFont(ofSize: 20)
                    
                    if(correcta.contains(".PNG") || correcta.contains(".png")){
                        if(correcta.contains(".PNG") || correcta.contains(".png")){
                            // create an NSMutableAttributedString that we'll append everything to
                            
                            let bundlePathResCorrecta = Bundle.main.path(forResource:correcta, ofType: nil)
                            
                            let fullString = NSMutableAttributedString(string: "Respuesta correcta:         ")
                            
                            // create our NSTextAttachment
                            let image1Attachment = NSTextAttachment()
                            image1Attachment.image = UIImage(contentsOfFile: bundlePathResCorrecta!)
                            
                            // wrap the attachment in its own attributed string so we can append it
                            let image1String = NSAttributedString(attachment: image1Attachment)
                            
                            // add the NSTextAttachment wrapper to our full string, then add some more text.
                            fullString.append(image1String)
                            //fullString.append(NSAttributedString(string: "End of text"))
                            
                            // draw the result in a label
                            self.correctaTootlipModal.attributedText = fullString
                            
                            var frame = self.correctaTootlipModal.frame
                            frame.size.height = self.correctaTootlipModal.contentSize.height
                            self.correctaTootlipModal.frame = frame
                            
                        }
                    }else{
                        correctaTootlipModal.text = "Respuesta Correcta: " + correcta
                    }
                    
                    
                    //tooltipModal.text = tooltip
                    
                }else{
                    if(correcta.contains(".PNG") || correcta.contains(".png")){
                        if(correcta.contains(".PNG") || correcta.contains(".png")){
                            // create an NSMutableAttributedString that we'll append everything to
                            let fullString = NSMutableAttributedString(string: "Respuesta correcta:         ")
                            
                            let bundlePathResCorrecta = Bundle.main.path(forResource:correcta, ofType: nil)
                            
                            // create our NSTextAttachment
                            let image1Attachment = NSTextAttachment()
                            image1Attachment.image = UIImage(contentsOfFile: bundlePathResCorrecta!)
                            
                            // wrap the attachment in its own attributed string so we can append it
                            let image1String = NSAttributedString(attachment: image1Attachment)
                            
                            // add the NSTextAttachment wrapper to our full string, then add some more text.
                            fullString.append(image1String)
                            //fullString.append(NSAttributedString(string: "End of text"))
                            
                            // draw the result in a label
                            self.correctaTootlipModal.attributedText = fullString
                            
                            var frame = self.correctaTootlipModal.frame
                            frame.size.height = self.correctaTootlipModal.contentSize.height
                            self.correctaTootlipModal.frame = frame
                            
                        }
                    }else{
                        correctaTootlipModal.text = "Respuesta Correcta: " + correcta
                    }
                    
                    tooltipModal.text = tooltip
                    
                     self.tooltipModal.font = .systemFont(ofSize: 20)                }
                
                mensajeTooltip.center = view.center
                self.view.addSubview(mensajeTooltip)
            }
            
            /*    let totalPreguntasInt = (numPreguntas! as NSString).integerValue - 1
             print("totalPreguntasInt \(totalPreguntasInt)")
             print("contador \(contador)")
             
             if(totalPreguntasInt == contador){
             self.performSegue(withIdentifier: "muestraResultados", sender: self)
             }else{
             contador = contador + 1
             pregunta()
             reloadTabla()
             }*/
            
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
    
    var tamanoPantallaXTooltipp: CGFloat!
    var tamanoPantallaYTooltipp: CGFloat!
    var tamanoPantallaYTooltippAcomoda: CGFloat!
    var scrollView: UIScrollView!
    
    
    @IBOutlet weak var scrollPreguntas: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tamanoPantallaXTooltipp = self.view.frame.size.width
        tamanoPantallaYTooltipp = self.view.frame.size.height
        tamanoPantallaYTooltippAcomoda = 60.0
        
        btnTooltipLeyenda.backgroundColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        print("materia: \(materia!)")
        print("numPreguntas: \(numPreguntas!)")
        print("ayuda: \(ayuda!)")
        // Do any additional setup after loading the view.
        
        self.tituloMateria.title = materia
        
        print("arrayPreguntas: \(arrayPreguntas)")

        //pregunta()
        
        tablaAnswers.rowHeight = UITableViewAutomaticDimension
        tablaAnswers.estimatedRowHeight = 140
        
        if(ayuda=="No"){
            botonTooltip.isHidden = true
        }
        
        pregImageInstrucciones.isScrollEnabled = true
        preguntaMainPincipal.isScrollEnabled = true
        
        self.tooltipModal.font = .systemFont(ofSize: 20)
        self.correctaTootlipModal.font = .systemFont(ofSize: 20)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pregunta()
        
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

    func adjustUITextViewHeight(arg : UITextView)
    {
        //arg.translatesAutoresizingMaskIntoConstraints = true
        //arg.sizeToFit()
        
        //arg.reloadInputViews()
        //arg.setNeedsDisplay()
        
        if(imagenSiNo==true){
            arg.isScrollEnabled = false
        }
        if(imagenSiNo==false){
            arg.isScrollEnabled = true
            arg.textAlignment = .justified
            arg.isSelectable = false
        }
        
        
    }
    
    func pregunta(){
        //     for i in 0  ..< arrayPreguntas.count  {
        //    print("i: \(i)")
        
        tamanoPantallaYTooltippAcomoda = 50.0
        
        respueta = ""
        
        tooltip = arrayPreguntas[contador]["tooltip"]!
        correcta = arrayPreguntas[contador]["correcta"]!
        imagenTooltip = arrayPreguntas[contador]["imagentooltip"]!
        
       // preguntaMainPincipal.text = ""
       // pregImageInstrucciones.text = ""
        
       // preguntaMainPincipal.adjustsFontForContentSizeCategory = false
       // pregImageInstrucciones.adjustsFontForContentSizeCategory = false
        
        preguntaMainPincipal.isScrollEnabled = false
        pregImageInstrucciones.isScrollEnabled = false
        
        self.preguntaMainPincipal.font = .systemFont(ofSize: 20)
        self.pregImageInstrucciones.font = .systemFont(ofSize: 20)

        self.preguntaMainPincipal.font = .systemFont(ofSize: 16)
        self.pregImageInstrucciones.font = .systemFont(ofSize: 16)
        
        if(arrayPreguntas[contador]["imagenpregunta"]! == ""){
            
            preguntaMainPincipal.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: tamanoPantallaYTooltipp)
            
            imagenSiNo = false
            preguntaMainPincipal.text = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
            pregImageInstrucciones.text = ""
            
            preguntaMainPincipal.isScrollEnabled = false
            
            preguntaMainPincipal.translatesAutoresizingMaskIntoConstraints = true
            preguntaMainPincipal.sizeToFit()
            preguntaMainPincipal.isEditable = false
            preguntaMainPincipal.isSelectable = false
            
            let fixedWidth = preguntaMainPincipal.frame.size.width
            
            let newSize = preguntaMainPincipal.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            preguntaMainPincipal.frame.size = CGSize(width: tamanoPantallaXTooltipp - 10.0, height: newSize.height)
            
            scrollPreguntas.addSubview(preguntaMainPincipal)
            
            //self.view.addSubview(scrollView)
            
            tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + preguntaMainPincipal.frame.size.height + 100.0
            
            pregImageInstrucciones.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: 10.0)
            
            scrollPreguntas.addSubview(pregImageInstrucciones)
            
            //self.view.addSubview(scrollView)

            
        }else{
            
            //pregImageInstrucciones.isHidden = false
            
            imagenSiNo = true
            
             print("imagenPreguntaMain: \(arrayPreguntas[contador]["imagenpregunta"]!)")
            
        let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
            let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
            
            imagenPreguntaMain = arrayPreguntas[contador]["imagenpregunta"]!
            let imageView = UIImageView(image: image)

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
            self.preguntaMainPincipal.attributedText = fullString
            
            var frame = self.preguntaMainPincipal.frame
            frame.size.height = self.preguntaMainPincipal.contentSize.height
            self.preguntaMainPincipal.frame = frame
            
            pregImageInstrucciones.text = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
            
            
            pregImageInstrucciones.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: tamanoPantallaYTooltipp)
            
            pregImageInstrucciones.isScrollEnabled = false
            
            pregImageInstrucciones.translatesAutoresizingMaskIntoConstraints = true
            pregImageInstrucciones.sizeToFit()
            pregImageInstrucciones.isEditable = false
            pregImageInstrucciones.isSelectable = false
            
            let fixedWidth = pregImageInstrucciones.frame.size.width
            
            let newSize = pregImageInstrucciones.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            pregImageInstrucciones.frame.size = CGSize(width: tamanoPantallaXTooltipp - 20.0, height: newSize.height)
            
            scrollPreguntas.addSubview(pregImageInstrucciones)            //self.view.addSubview(scrollView)
            
            tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + pregImageInstrucciones.frame.size.height + 30.0
            
            
            preguntaMainPincipal.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: tamanoPantallaYTooltipp)
            
            preguntaMainPincipal.isScrollEnabled = false
            
            preguntaMainPincipal.translatesAutoresizingMaskIntoConstraints = true
            preguntaMainPincipal.sizeToFit()
            preguntaMainPincipal.isEditable = false
            preguntaMainPincipal.isSelectable = false
            
            let fixedWidthPreg = preguntaMainPincipal.frame.size.width
            
            let newSizePreg = preguntaMainPincipal.sizeThatFits(CGSize(width: fixedWidthPreg, height: CGFloat.greatestFiniteMagnitude))
            
            preguntaMainPincipal.frame.size = CGSize(width: tamanoPantallaXTooltipp, height: newSizePreg.height)
            
            scrollPreguntas.addSubview(preguntaMainPincipal)
            
            //self.view.addSubview(scrollView)
            
            tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + pregImageInstrucciones.frame.size.height + 100.0
            

            
        }
        
        adjustUITextViewHeight(arg: preguntaMainPincipal)
        adjustUITextViewHeight(arg: pregImageInstrucciones)
        
        /*var frame = self.preguntaMainPincipal.frame
        frame.size.height = self.preguntaMainPincipal.contentSize.height
        self.preguntaMainPincipal.frame = frame
        
        var frame2 = self.pregImageInstrucciones.frame
        frame2.size.height = self.pregImageInstrucciones.contentSize.height
        self.pregImageInstrucciones.frame = frame2*/
        
        
        print("tamanoPantallaYTooltippAcomoda: \(tamanoPantallaYTooltippAcomoda)")
        
        let fixedWidthPreg = tablaAnswers.frame.size.width
        
        let newSizePreg = tablaAnswers.sizeThatFits(CGSize(width: fixedWidthPreg, height: CGFloat.greatestFiniteMagnitude))
        
        //tamanoPantallaXTooltipp = tamanoPantallaXTooltipp + 100.0
        
        tablaAnswers.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: 0.0, height: 0.0)
        
        tablaAnswers.frame.size = CGSize(width: tamanoPantallaXTooltipp, height: newSizePreg.height)
        
        tablaAnswers.translatesAutoresizingMaskIntoConstraints = false
        tablaAnswers.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        tablaAnswers.sizeToFit()
        
        tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + tablaAnswers.frame.height + 50.0
        
        scrollPreguntas.addSubview(tablaAnswers)
        
        

        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRespuestas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "radiosRespue", for: indexPath)
        
       
        
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
        let nombreCategoria = arrayRespuestas[indexPath.row]
        print("nombreCategoria \(nombreCategoria)")
        
        let bundlePath = Bundle.main.path(forResource: arrayRespuestas[indexPath.row].trimmingCharacters(in: .whitespaces), ofType: nil)
        
        let imagen = "an_ic_radiobutton_off.png"
        
        let bundlePathRadio = Bundle.main.path(forResource:imagen, ofType: nil)
        
        
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 15, width: 30, height: 30))
        myImageView.image = UIImage(contentsOfFile: bundlePathRadio!)
        
        if(nombreCategoria.contains(".PNG") || nombreCategoria.contains(".png") ){
            cell.imageView?.image = myImageView.image
            
            // create an NSMutableAttributedString that we'll append everything to
            let fullString = NSMutableAttributedString(string: "")
            
            // create our NSTextAttachment
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(contentsOfFile: bundlePath!  )
            
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            
            // add the NSTextAttachment wrapper to our full string, then add some more text.
            fullString.append(image1String)
            //fullString.append(NSAttributedString(string: "End of text"))
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.attributedText = fullString
            
        }else{
        cell.imageView?.image = myImageView.image
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = nombreCategoria as String?
        }
        
        return cell
    }
    
    func reloadTabla(){
        self.tablaAnswers.reloadData()
        self.preguntaMainPincipal.becomeFirstResponder()
        self.pregImageInstrucciones.becomeFirstResponder()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //   let cell = tableView.dequeueReusableCell(withIdentifier: "cellcuestionario", for: indexPath)
        let cell = tableView.cellForRow(at: indexPath)
        var imagen = ""
        
        //reloadTabla()
        
        let fila = indexPath
        print("fila \(fila.row)")
        

        
        imagen = "an_ic_radiobutton_on.png"
        
        let bundlePathRadio = Bundle.main.path(forResource:imagen, ofType: nil)
        
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

            if segue.identifier == "muestraResultados"{
                print("materia: \(materia!)")
                let correctasFinalTotal = "\(contadorCorrectas)"
                let objVista2 = segue.destination as! ResultadosMateriaViewController
                objVista2.asignatura = materia
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
