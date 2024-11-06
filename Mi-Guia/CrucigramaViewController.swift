//
//  CrucigramaViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/11/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit

class CrucigramaViewController: UIViewController {

    var materia:String?
    var numPreguntas:String?
    var ayuda:String?
    var arrayPreguntas:[[String:String]] = []
    
    var pregunta:String=""
    var respCorrecta:String=""
    var contadorPregunta:Int=0
    var totalPreguntasInt:Int=0
    
    var tamanoPantallaXPregunta: CGFloat!
    var tamanoPantallaYPregunta: CGFloat!
    
    var preguntaMain: UITextView!
    var preguntaImagenMain: UITextView!
    var buttonCalificar: UIButton!
    var buttonAyuda: UIButton!
    var contadorCorrectas:Int = 0
    var imagenTooltip:String = ""
    var explicacionTooltipp: UITextView!
    
    var tooltipTexto:String = ""
    
    var tamanoPantallaXTooltipp: CGFloat!
    var tamanoPantallaYTooltipp: CGFloat!
    var tamanoPantallaYTooltippAcomoda: CGFloat!
    
    var encabezadoAyuda: UILabel!
    
    var listOfTextFields : [UITextField] = []
    
    
    @IBOutlet weak var tituloMateria: UINavigationBar!
    
    
    @IBOutlet var tooltip: UIView!
    
    
    @IBOutlet weak var nombreMateria: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UINavigationBar.appearance().barTintColor = UIColor(red:0.70, green:0.45, blue:0.27, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        tamanoPantallaXPregunta = CGFloat((view?.bounds.maxX)!)
        
        self.nombreMateria.title = materia
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CrucigramaViewController.dismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.siguienteShowPreguntaNext()
        
    }
    
    func cargandoPreguntas(){
        
        self.addCuestions()
        
        DispatchQueue.main.async {
            
            do {
                
                self.siguienteShowPreguntaNext()
                
                OperationQueue.main.addOperation {
                    self.boxView.removeFromSuperview()
                }
            } catch {
                print("error in Concurrent Queue)")
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
    
    
    @objc func dismissKeyboard(){
        
        for j in 0..<listOfTextFields.count{
            listOfTextFields[j].resignFirstResponder()
        }
        
    }
    
    
    var scrollView: UIScrollView!
    
    func siguienteShowPreguntaNext() {
        
        tamanoPantallaYPregunta = CGFloat((view?.bounds.maxY)!)
        
        listOfTextFields = []
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 85.00, width: tamanoPantallaXPregunta, height: tamanoPantallaYPregunta))
        scrollView.contentSize = CGSize(width: tamanoPantallaXPregunta, height: 2000)
        
        tamanoPantallaYPregunta = 10.0
        
        respCorrecta = arrayPreguntas[contadorPregunta]["correcta"]!
        tooltipTexto = arrayPreguntas[contadorPregunta]["tooltip"]!
        imagenTooltip = arrayPreguntas[contadorPregunta]["imagentooltip"]!
        
        tamanoPantallaYPregunta =  tamanoPantallaYPregunta + 15.0
        
        //Azul
        //UIColor(red:0.00, green:0.17, blue:0.48, alpha:1.0)
        //Dorado
        //UIColor(red:0.84, green:0.62, blue:0.06, alpha:1.0)
        
        if(arrayPreguntas[contadorPregunta]["imagenpregunta"]! == ""){
            
            preguntaMain = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 20.0 , height: 100.0))
            preguntaMain.backgroundColor = UIColor(red:0.05, green:0.29, blue:0.19, alpha:1.0)
            //preguntaMain.backgroundColor = UIColor(patternImage: UIImage(named: "blackboardtooltip")!)
            preguntaMain.textColor = .white
            
            //imagenSiNo = false
            preguntaMain.text = arrayPreguntas[contadorPregunta]["pregunta"]!.trimmingCharacters(in: .whitespaces)
            
            self.preguntaMain.font = .systemFont(ofSize: 20)
            
            preguntaMain.isScrollEnabled = false
            
            preguntaMain.translatesAutoresizingMaskIntoConstraints = true
            preguntaMain.sizeToFit()
            preguntaMain.isEditable = false
            preguntaMain.isSelectable = false
            
            let fixedWidth = preguntaMain.frame.size.width
            
            let newSize = preguntaMain.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            preguntaMain.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            scrollView.addSubview(preguntaMain)
            
            self.view.addSubview(scrollView)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + preguntaMain.frame.size.height + 10.0
            
            //self.view..center = view.center
            //self.view.addSubview(vistaPreguntas)
            
        }else{
            
            preguntaMain = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 10.0, height: 100.0))
            preguntaMain.backgroundColor = .white
            preguntaMain.textColor = .black
            
            //imagenSiNo = false
            preguntaMain.text = arrayPreguntas[contadorPregunta]["pregunta"]!.trimmingCharacters(in: .whitespaces)
            
            self.preguntaMain.font = .systemFont(ofSize: 20)
            
            preguntaMain.isScrollEnabled = false
            
            preguntaMain.translatesAutoresizingMaskIntoConstraints = true
            preguntaMain.sizeToFit()
            
            preguntaMain.isEditable = false
            preguntaMain.isSelectable = false
            
            //self.vistaTooltip.addSubview(preguntaMain)
            
            scrollView.addSubview(preguntaMain)
            
            self.view.addSubview(scrollView)
            
            tamanoPantallaYPregunta = preguntaMain.frame.size.height + 150.0
            
            preguntaImagenMain = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 10.0, height: 100.0))
            preguntaImagenMain.backgroundColor = .white
            preguntaImagenMain.textColor = .black
            
            preguntaImagenMain.isScrollEnabled = false
            self.preguntaImagenMain.font = .systemFont(ofSize: 20)
            
            preguntaImagenMain.isEditable = false
            preguntaImagenMain.isSelectable = false
            
            // imagenSiNo = true
            
            let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contadorPregunta]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
            let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
            
            //imagenPreguntaMain = arrayPreguntas[contador]["imagenpregunta"]!
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
            self.preguntaImagenMain.attributedText = fullString
            
            var frame = self.preguntaImagenMain.frame
            frame.size.height = self.preguntaImagenMain.contentSize.height
            self.preguntaImagenMain.frame = frame
            
            //Ajustando la caja al contenido
            self.preguntaImagenMain.font = .systemFont(ofSize: 20)
            
            preguntaImagenMain.isScrollEnabled = false
            
            preguntaImagenMain.translatesAutoresizingMaskIntoConstraints = true
            preguntaImagenMain.sizeToFit()
            
            //self.vistaTooltip.addSubview(preguntaImagenMain)
            scrollView.addSubview(preguntaImagenMain)
            
            self.view.addSubview(scrollView)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + preguntaImagenMain.frame.size.height + 10
            
            //  vistaPreguntas.center = view.center
            //  self.view.addSubview(vistaPreguntas)
            
        }
        
        var sizeY = 0.00
        
        sizeY = Double(Float(tamanoPantallaYPregunta + 10.00))
        let contanteRenglon: Float = 40.00
        
        let tamanoPantalla = Float(self.view.bounds.maxX)
        print("tamanoPantalla: \(tamanoPantalla)")
        let renglones = Int((Float(respCorrecta.count) / Float(tamanoPantalla/contanteRenglon)))
        print("renglones: \(renglones)")
        let residuo = (Float(respCorrecta.count) / Float(tamanoPantalla/contanteRenglon)) - Float(renglones)
        print("residuo: \(residuo)")
        let residuoUno = 1 - residuo
        let residuoDOs = residuoUno + residuo
        let totalRenglones = Int(residuoDOs) + Int(renglones)
        let tamanoPorRenglon = Int(tamanoPantalla / contanteRenglon)
        var parrafoIni = 0
        var contador = 0
        
        print("totalRenglones: \(totalRenglones)")
        print("tamanoPorRenglon: \(tamanoPorRenglon)")
        
        let noVocales = "aAáÁeEéÉiIíÍoOóÓuUúÚ"
        
        for _ in 0..<totalRenglones{
            var sizeX = 10.00
            
            for i in 0..<respCorrecta.count {
                
                let start = respCorrecta.index(respCorrecta.startIndex, offsetBy: i)
                
                //  let end = palabra.index(palabra.endIndex, offsetBy: i)
                let range = start
                
                let respuesta = respCorrecta[range]
                
                let letra = String(respuesta)
                
                // print("mod: \(i%tamanoPorRenglon)")
                
                if((i>=contador)){
                    print("contador: \(contador)")
                    print("i: \(i)")
                    print("letra: \(respuesta)")
                    
                    let txtField: UITextField = UITextField(frame: CGRect(x: sizeX, y: Double(sizeY), width: 35.00, height: 35.00))
                    
                    checkMaxLength(textField: txtField, maxLength: 1)
                    
                    txtField.borderStyle = UITextField.BorderStyle.line
                    
                    let novowles = String(String(respuesta).filter({!noVocales.contains(String($0))}))
                    
                    //txtField.text = String(respuesta)
                    
                    txtField.text = String(novowles)
                    txtField.textAlignment = .center
                    
                    if(!String(novowles).isEmpty || String(novowles) != " "){
                        txtField.isUserInteractionEnabled = false
                    }
                    if(String(novowles).isEmpty || String(novowles) == " "){
                        print("novowles: \(novowles)")
                        txtField.isUserInteractionEnabled = true
                    }
                    
                    if(letra==" "){
                        txtField.text = " "
                        txtField.backgroundColor = UIColor.black
                        txtField.isUserInteractionEnabled = false
                    }else{
                        txtField.backgroundColor = UIColor.white
                    }
                    listOfTextFields.append(txtField)
                    
                    sizeX = sizeX + Double(contanteRenglon)
                    
                    // parrafoIni = i
                    if((i+1)%tamanoPorRenglon==0 && i>0){
                        parrafoIni = i + 1
                        break
                    }
                    
                    
                }
                
            }
            
            sizeY = sizeY + 40
            contador = parrafoIni
            
        }
        
        
        for j in 0..<listOfTextFields.count{
            scrollView.addSubview(listOfTextFields[j])
            self.view.addSubview(scrollView)
            
            
            listOfTextFields[j].addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        }
        
        tamanoPantallaYPregunta = CGFloat(sizeY) + 15.00
        
        buttonCalificar = UIButton()
        buttonCalificar.frame = CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 20.0, height: 30)
        buttonCalificar.backgroundColor = UIColor(red:0.00, green:0.45, blue:0.81, alpha:1.0)
        buttonCalificar.setTitle("Calificar", for: .normal)
        buttonCalificar.addTarget(self, action: #selector(buttonActionCalificar), for: .touchUpInside)
        
        scrollView.addSubview(buttonCalificar)
        
        tamanoPantallaYPregunta = tamanoPantallaYPregunta + 50.0
        
        buttonAyuda = UIButton()
        buttonAyuda.frame = CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 20.0, height: 30)
        buttonAyuda.backgroundColor = UIColor(red:0.00, green:0.45, blue:0.81, alpha:1.0)
        buttonAyuda.setTitle("Ayuda", for: .normal)
        buttonAyuda.addTarget(self, action: #selector(buttonActionAyuda), for: .touchUpInside)
        
        scrollView.addSubview(buttonAyuda)
        
        
        tamanoPantallaYPregunta = tamanoPantallaYPregunta + 550.0
        
        scrollView.contentSize = CGSize(width: tamanoPantallaXPregunta, height: tamanoPantallaYPregunta)
        
        self.view.addSubview(scrollView)
        
        
    }
    
    
    @objc func buttonActionCalificar(sender: UIButton!) {
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        var titulo:String = ""
        var mensaje:String = ""
        
        var palabraEscrita:String = ""
        var contadorBuenas: Int = 0
        
        for j in 0..<listOfTextFields.count{
            checkMaxLength(textField: listOfTextFields[j], maxLength: 1)
            
            palabraEscrita = listOfTextFields[j].text!
            let start = respCorrecta.index(respCorrecta.startIndex, offsetBy: j)
            let range = start
            let respuesta = respCorrecta[range]
            let letra = String(respuesta)
            let bar = letra.folding(options: .diacriticInsensitive, locale: .current)
            
            if((palabraEscrita.lowercased() == letra.lowercased()) || (palabraEscrita.lowercased() == bar.lowercased())){
                contadorBuenas = contadorBuenas + 1
                print("correcta \(j) : \(letra)")
            }else{
                print("No correcta \(j) : \(letra)")
            }
            
        }
        
        var calificaFrase:Int=0
        calificaFrase =  respCorrecta.count - contadorBuenas
        
        if(calificaFrase<=2){
            
            contadorCorrectas = contadorCorrectas + 1
            
            titulo = "¡Correcta!"
            mensaje = "¡Muy bien!"
            print("PalabraCorrecta")
            
            for j in 0..<listOfTextFields.count{
                
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.5
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: listOfTextFields[j].center.x - 10, y: listOfTextFields[j].center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: listOfTextFields[j].center.x + 10, y: listOfTextFields[j].center.y))
                let colorido = UIColor(red:0.82, green:0.66, blue:0.11, alpha:1.0)
                listOfTextFields[j].layer.borderWidth = 4
                listOfTextFields[j].layer.borderColor = colorido.cgColor
                listOfTextFields[j].layer.add(animation, forKey: "position")
            }
        }else{
            titulo = "Incorrecta"
            mensaje = "Intenta con otra pregunta"
            print("PalabraIncorrecta")
            for j in 0..<listOfTextFields.count{
                
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: listOfTextFields[j].center.x - 10, y: listOfTextFields[j].center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: listOfTextFields[j].center.x + 10, y: listOfTextFields[j].center.y))
                listOfTextFields[j].layer.add(animation, forKey: "position")
            }
        }
        
        
        
        let alert = UIAlertController(title: titulo, message:  mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                
                self.contadorPregunta = self.contadorPregunta + 1
                
                for j in 0..<self.listOfTextFields.count{
                    
                    self.listOfTextFields[j].removeFromSuperview()
                }
                
                /* if(self.arrayPreguntas[self.contadorPregunta]["imagenpregunta"]! == ""){
                 self.preguntaMain.removeFromSuperview()
                 }else{
                 self.preguntaMain.removeFromSuperview()
                 
                 for view in self.view.subviews{
                 if(!view.contains(self.preguntaImagenMain)){
                 self.preguntaImagenMain.removeFromSuperview()
                 }
                 }
                 }*/
                
                for view in self.scrollView.subviews{
                    if(!view.contains(self.tituloMateria as! UIFocusEnvironment)){
                        view.removeFromSuperview()
                    }
                }
                
                //self.buttonCalificar.removeFromSuperview()
                //self.buttonAyuda.removeFromSuperview()
                
                let totalPreguntasInt = (self.numPreguntas! as NSString).integerValue - 1
                
                if(totalPreguntasInt == self.contadorPregunta){
                    
                    self.performSegue(withIdentifier: "muestraResultados", sender: self)
                    
                }else{
                    
                    
                    self.siguienteShowPreguntaNext()
                    
                }
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
        /*contadorPregunta = contadorPregunta + 1
         
         for j in 0..<listOfTextFields.count{
         
         listOfTextFields[j].removeFromSuperview()
         }
         
         if(arrayPreguntas[contadorPregunta]["imagenpregunta"]! == ""){
         preguntaMain.removeFromSuperview()
         }else{
         preguntaMain.removeFromSuperview()
         preguntaImagenMain.removeFromSuperview()
         }
         
         buttonCalificar.removeFromSuperview()
         buttonAyuda.removeFromSuperview()
         
         if(totalPreguntasInt == self.contadorPregunta){
         
         self.performSegue(withIdentifier: "muestraResultados", sender: self)
         
         }else{
         self.contadorPregunta = self.contadorPregunta + 1
         siguienteShowPreguntaNext()
         }*/
        
        
        //iniciaJuego()
    }
    
    
    @objc func buttonActionAyuda(sender: UIButton!) {
        print("Button tapped ayuda")
        ayudaTooltip()
        //contador = contador + 1
        //self.view.removeFromSuperview()
        //iniciaJuego()
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        for _ in 0..<String(textField.text!).count {
            if (String(textField.text!).count > maxLength) {
                textField.deleteBackward()
            }
        }
        
    }
    
    
    func ayudaTooltip(){
        
        for view in tooltip.subviews{
            //if(!view.contains(encabezadoAyuda)){
            view.removeFromSuperview()
            //}
        }
        
        tamanoPantallaXTooltipp = tooltip.frame.size.width
        tamanoPantallaYTooltipp = tooltip.frame.size.height
        tamanoPantallaYTooltippAcomoda = 50.0
        
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: tamanoPantallaXTooltipp, height: tamanoPantallaYTooltipp))
        scrollView.contentSize = CGSize(width: tamanoPantallaXTooltipp, height: 3000)
        
        encabezadoAyuda = UILabel(frame: CGRect(x: 10.0, y: 10.0, width: tamanoPantallaXTooltipp, height: 30.0))
        encabezadoAyuda.backgroundColor = .blue
        encabezadoAyuda.textColor = .white
        encabezadoAyuda.textAlignment = .center
        
        encabezadoAyuda.text = "AYUDA"
        
        scrollView.addSubview(encabezadoAyuda)
        
        self.tooltip.addSubview(scrollView)
        
        if(imagenTooltip.contains(".PNG") || imagenTooltip.contains(".png")){
            // create an NSMutableAttributedString that we'll append everything to
            
            explicacionTooltipp = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: 100.0))
            explicacionTooltipp.backgroundColor = .white
            explicacionTooltipp.textColor = .black
            
            explicacionTooltipp.isUserInteractionEnabled = false
            
            self.explicacionTooltipp.font = .systemFont(ofSize: 20)
            
            let fullString = NSMutableAttributedString(string: tooltipTexto + "\n\n")
            
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
            self.explicacionTooltipp.attributedText = fullString
            
            var frame = self.explicacionTooltipp.frame
            frame.size.height = self.explicacionTooltipp.contentSize.height
            self.explicacionTooltipp.frame = frame
            
            let fixedWidth = explicacionTooltipp.frame.size.width
            
            let newSize = explicacionTooltipp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            explicacionTooltipp.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + explicacionTooltipp.frame.size.height + 5.0
            
            scrollView.addSubview(explicacionTooltipp)
            
            self.tooltip.addSubview(scrollView)
            
            
        }else{
            
            explicacionTooltipp = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0 , height: 100.0))
            explicacionTooltipp.backgroundColor = .white
            explicacionTooltipp.textColor = .black
            
            explicacionTooltipp.isUserInteractionEnabled = false
            
            self.explicacionTooltipp.font = .systemFont(ofSize: 20)
            
            explicacionTooltipp.text = tooltipTexto
            
            let fixedWidth = explicacionTooltipp.frame.size.width
            
            let newSize = explicacionTooltipp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            explicacionTooltipp.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + explicacionTooltipp.frame.size.height + 5.0
            
            scrollView.addSubview(explicacionTooltipp)
            
            self.tooltip.addSubview(scrollView)
        }
        
        scrollView.addSubview(explicacionTooltipp)
        
        let button = UIButton()
        button.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltipp - 20.0, height: 30)
        button.backgroundColor = UIColor.red
        button.setTitle("Cerrar", for: .normal)
        button.addTarget(self, action: #selector(cerrarAyuda), for: .touchUpInside)
        
        scrollView.addSubview(button)
        
        tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + 50.0
        
        scrollView.contentSize = CGSize(width: tamanoPantallaXTooltipp, height: tamanoPantallaYTooltippAcomoda)
        
        
        self.tooltip.addSubview(scrollView)
        
        tooltip.center = view.center
        self.view.addSubview(tooltip)
        
        
    }
    
    @objc func cerrarAyuda(sender: UIButton!) {
        
        self.tooltip.removeFromSuperview()
        
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
    
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.utf16.count==1){
            
            for j in 0..<listOfTextFields.count{
                let texto = listOfTextFields[j].text
                if(texto?.utf16.count==0){
                    listOfTextFields[j].becomeFirstResponder()
                    break
                }
                
                //break
            }
            
        }else{
            
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
