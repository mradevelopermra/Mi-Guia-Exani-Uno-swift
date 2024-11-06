//
//  GameViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/13/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var materia:String?
    var numPreguntas:String?
    var ayuda:String?
    var arrayPreguntas:[[String:String]] = []
    var arrayPreguntasPorJuego:[[String:String]] = []
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
    
    var instrucciones: UILabel!
    var preguntaMain: UITextView!
    var respUnoModal: UITextView!
    var respDosModal: UITextView!
    var respTresModal: UITextView!
    var respCuatroModal: UITextView!
    
    var preguntaImagenMain: UITextView!
    var vistaJuego: SKView!
    
    var tamanoPantallaX: CGFloat!
    var tamanoPantallaY: CGFloat!
    var tamanoPantallaXPregunta: CGFloat!
    var tamanoPantallaYPregunta: CGFloat!
    var tamanoPantallaXTooltip: CGFloat!
    var tamanoPantallaYTooltipp: CGFloat!
    var tamanoPantallaYTooltippAcomoda: CGFloat!
    
    var explicacionTooltipp: UITextView!
    var respCorrectaTooltipp: UITextView!
    
    var muestraInstruccion:Bool = true
    
    
    @IBOutlet weak var scrollFondoJuego: UIScrollView!
    
    
    @IBOutlet var vistaTooltip: UIView!
    
    
    @IBOutlet var vistaPreguntas: UIView!
    
    
    @IBOutlet weak var nombreMateria: UINavigationItem!
    
    
    @IBOutlet weak var encabezadoAyuda: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(muestraInstruccion==true){
            instruccion()
        }
    }
    
    var aciertos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        tamanoPantallaX = CGFloat((view?.bounds.maxX)!)
        tamanoPantallaY = CGFloat((view?.bounds.maxY)!)
        
        // Pause the view (and thus the game) when the app is interrupted or backgrounded
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.handleApplicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.handleApplicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        //self.title = materia
        self.nombreMateria.title = materia
        
        scrollFondoJuego.backgroundColor = UIColor(patternImage: UIImage(named:"backgroundfinal")!)
        
        aciertos = UILabel(frame: CGRect(x: 10.0, y: 80.0, width: tamanoPantallaX - 10.0 , height: 20.0))
        
        aciertos.text = "Aciertos: 0"
        aciertos.textColor = .white
        aciertos.textAlignment = .center
        
        scrollFondoJuego.addSubview(aciertos)
        
        
        
    }
    
    
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    //var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var timerTest : Timer?
    
    func runTimer() {
        guard timerTest == nil else { return }
        seconds = 60
        timerTest = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        
        seconds -= 1     //This will decrement(count down)the seconds.
        // timerLabel.text = “\(seconds)” //This will update the label.
        print("Tiempo: \(seconds)")
        if(seconds==0){
            seconds = 60
            stopTimerTest()
            instrucciones.textColor = .red
            instrucciones.textAlignment = .center
            instrucciones.text = "¡Inicia la invasiòn!"
            self.vistaPreguntas.removeFromSuperview()
            iniciaJuego()
        }else if(seconds<=0){
            stopTimerTest()
            seconds = 60
        }else if(seconds<10){
            stopTimerTest()
            instrucciones.textColor = .blue
            instrucciones.textAlignment = .center
            instrucciones.text = "00:00:0\(seconds)"
        }else{
            instrucciones.textColor = .blue
            instrucciones.textAlignment = .center
            instrucciones.text = "00:00:\(seconds)"
        }
        
        
    }
    
    func stopTimerTest() {
        timerTest?.fire()
        timerTest?.invalidate()
        timerTest = nil
    }
    
    
    func instruccion(){
        let alert = UIAlertController(title: "Instrucciones", message: "¡Encuentra la respuesta correcta y destruyela, pero recuerda tienes 60 segundos antes de que la invasiòn inicie!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
                
                self.cargandoPreguntas()
                /*   self.pregunta()
                 self.siguienteShowPreguntaNext()
                 self.scrollFondoJuego.backgroundColor = UIColor(patternImage: UIImage(named:"backgroundfinal")!)*/
                //self.iniciaJuego()
                
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        present(alert, animated: true, completion: nil)
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
    func cargandoPreguntas(){
        
        self.addCuestions()
        
        DispatchQueue.main.async {
            
            do {
                
                self.pregunta()
                self.siguienteShowPreguntaNext()
                self.scrollFondoJuego.backgroundColor = UIColor(patternImage: UIImage(named:"backgroundfinal")!)
                
                OperationQueue.main.addOperation {
                    self.boxView.removeFromSuperview()
                }
            } catch {
                print("error in Concurrent Queue)")
            }
        }
        
    }
    
    func iniciaJuego(){
        
        if let viewWithTag = self.view.viewWithTag(100) {
              viewWithTag.removeFromSuperview()
          }else{
              print("No!")
          }
        
        vistaJuego = SKView(frame: CGRect(x: 0.0, y: 70.0, width: tamanoPantallaX, height: tamanoPantallaY))
        vistaJuego.backgroundColor = .clear
        vistaJuego.scene?.backgroundColor = .clear
        vistaJuego.allowsTransparency = true
        vistaJuego.tag = 100
        
        self.view.addSubview(vistaJuego)
        // Configure the view.
        let skView = vistaJuego as SKView
        
        // skView.removeFromSuperview()
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        skView.backgroundColor = .clear
        
        let scene = GameScene()
        
        scene.size = skView.frame.size
        scene.viewController = self
        scene.backgroundColor = .clear
        skView.presentScene(scene)
    }
    
    func pregunta(){
        //     for i in 0  ..< arrayPreguntas.count  {
        //    print("i: \(i)")
        
        respueta = ""
        
        tooltip = arrayPreguntas[contador]["tooltip"]!
        correcta = arrayPreguntas[contador]["correcta"]!
        imagenTooltip = arrayPreguntas[contador]["imagentooltip"]!
        
        /*vistaJuego = SKView(frame: CGRect(x: 0.0, y: 70.0, width: tamanoPantallaX, height: tamanoPantallaY))
        vistaJuego.backgroundColor = .clear
        vistaJuego.scene?.backgroundColor = .clear
        vistaJuego.allowsTransparency = true*/
        //self.vistaJuego.backgroundColor = UIColor(patternImage: UIImage(named:"backgroundfinal")!)
        
        //self.view.addSubview(vistaJuego)
        
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
    
    func siguienteShowPreguntaNext() {
        
        encabezadoAyuda.text = "Pregunta"
        
        tooltip = arrayPreguntas[contador]["tooltip"]!
        correcta = arrayPreguntas[contador]["correcta"]!
        imagenTooltip = arrayPreguntas[contador]["imagentooltip"]!
        
        for view in vistaPreguntas.subviews{
            if(!view.contains(encabezadoAyuda)){
                view.removeFromSuperview()
            }
        }
        
        tamanoPantallaYPregunta = 10.0
        tamanoPantallaXPregunta = vistaPreguntas.frame.size.width
        let tamanoPantallaYtooltip = vistaPreguntas.frame.size.height
        
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: tamanoPantallaXPregunta, height: tamanoPantallaYtooltip))
        scrollView.contentSize = CGSize(width: tamanoPantallaXPregunta, height: 2000)
        
        instrucciones = UILabel(frame: CGRect(x: 10.0, y: 10.0, width: tamanoPantallaXPregunta - 10.0 , height: 20.0))
        
        instrucciones.text = "00:00:60"
        instrucciones.backgroundColor = .white
        instrucciones.textColor = .blue
        instrucciones.textAlignment = .center
        
        runTimer()
        
        scrollView.addSubview(instrucciones)
        
        self.vistaPreguntas.addSubview(scrollView)
        
        tamanoPantallaYPregunta = tamanoPantallaYPregunta + instrucciones.frame.size.height + 50
        
        vistaPreguntas.center = view.center
        self.view.addSubview(vistaPreguntas)
        
        if(arrayPreguntas[contador]["imagenpregunta"]! == ""){
            
            preguntaMain = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 10.0 , height: 100.0))
            preguntaMain.backgroundColor = .white
            preguntaMain.textColor = .black
            
            preguntaMain.isScrollEnabled = false
            preguntaMain.isEditable = false
            preguntaMain.isSelectable = false
            
            imagenSiNo = false
            preguntaMain.text = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
            
            self.preguntaMain.font = .systemFont(ofSize: 20)
            
            preguntaMain.isScrollEnabled = false
            
            preguntaMain.translatesAutoresizingMaskIntoConstraints = true
            preguntaMain.sizeToFit()
            
            let fixedWidth = preguntaMain.frame.size.width
            
            let newSize = preguntaMain.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            preguntaMain.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            scrollView.addSubview(preguntaMain)
            
            self.vistaPreguntas.addSubview(scrollView)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + preguntaMain.frame.size.height + 50
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }else{
            
            preguntaMain = UITextView(frame: CGRect(x: 10.0, y: 50.0, width: tamanoPantallaXPregunta - 10.0, height: 100.0))
            preguntaMain.backgroundColor = .white
            preguntaMain.textColor = .black
            
            imagenSiNo = false
            preguntaMain.text = arrayPreguntas[contador]["pregunta"]!.trimmingCharacters(in: .whitespaces)
            
            self.preguntaMain.font = .systemFont(ofSize: 20)
            
            preguntaMain.isScrollEnabled = false
            
            preguntaMain.translatesAutoresizingMaskIntoConstraints = true
            preguntaMain.sizeToFit()
            
            preguntaMain.isScrollEnabled = false
            preguntaMain.isEditable = false
            preguntaMain.isSelectable = false
            //self.vistaTooltip.addSubview(preguntaMain)
            
            scrollView.addSubview(preguntaMain)
            
            self.vistaPreguntas.addSubview(scrollView)
            
            tamanoPantallaYPregunta = preguntaMain.frame.size.height + 50.0
            
            preguntaImagenMain = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 10.0, height: 100.0))
            preguntaImagenMain.backgroundColor = .white
            preguntaImagenMain.textColor = .black
            preguntaImagenMain.isEditable = false
            
            preguntaImagenMain.isScrollEnabled = false
            self.preguntaImagenMain.font = .systemFont(ofSize: 20)
            imagenSiNo = true
            
            let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["imagenpregunta"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
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
            
            self.vistaPreguntas.addSubview(scrollView)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + preguntaImagenMain.frame.size.height + 50
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }
        
        if(arrayPreguntas[contador]["respuestauno"]!.contains(".PNG") ||
            arrayPreguntas[contador]["respuestauno"]!.contains(".png")){
            
            respUnoModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 10.0, height: 100.0))
            respUnoModal.backgroundColor = .white
            respUnoModal.textColor = .black
            respUnoModal.isEditable = false
            
            respUnoModal.isScrollEnabled = false
            self.respUnoModal.font = .systemFont(ofSize: 20)
            imagenSiNo = true
            
            let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["respuestauno"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
            let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
            
            imagenPreguntaMain = arrayPreguntas[contador]["respuestauno"]!
            let imageView = UIImageView(image: image)
            
            imageView.image = UIImage(contentsOfFile: bundlePath!)
            
            // create an NSMutableAttributedString that we'll append everything to
            //let fullString = NSMutableAttributedString(string: "")
            let fullString = NSMutableAttributedString(string: "(1)  ")
            
            // create our NSTextAttachment
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(contentsOfFile: bundlePath!)
            
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            
            // add the NSTextAttachment wrapper to our full string, then add some more text.
            fullString.append(image1String)
            //fullString.append(NSAttributedString(string: "End of text"))
            
            // draw the result in a label
            self.respUnoModal.attributedText = fullString
            
            var frame = self.respUnoModal.frame
            frame.size.height = self.respUnoModal.contentSize.height
            self.respUnoModal.frame = frame
            
            scrollView.addSubview(respUnoModal)
            
            //self.vistaTooltip.addSubview(scrollView)
            
            //self.view.addSubview(respUnoModal)
            
            //Ajustando caja de contenido de la imagen
            
            respUnoModal.isScrollEnabled = false
            
            respUnoModal.translatesAutoresizingMaskIntoConstraints = true
            respUnoModal.sizeToFit()
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respUnoModal.frame.size.height + 5.0
            
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }else{
            
            respUnoModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 10.0, height: 100.0))
            respUnoModal.backgroundColor = .white
            respUnoModal.textColor = .black
            respUnoModal.isEditable = false
            
            imagenSiNo = false
            respUnoModal.text = "(1) " + arrayPreguntas[contador]["respuestauno"]!.trimmingCharacters(in: .whitespaces)
            
            self.respUnoModal.font = .systemFont(ofSize: 20)
            
            respUnoModal.isScrollEnabled = false
            
            respUnoModal.translatesAutoresizingMaskIntoConstraints = true
            respUnoModal.sizeToFit()
            
            let fixedWidth = respUnoModal.frame.size.width
            
            let newSize = respUnoModal.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            respUnoModal.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respUnoModal.frame.size.height + 5.0
            
            scrollView.addSubview(respUnoModal)
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaTooltip.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }
        
        
        if(arrayPreguntas[contador]["respuestados"]!.contains(".PNG") ||
            arrayPreguntas[contador]["respuestados"]!.contains(".png")){
            
            respDosModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta, height: 100.0))
            respDosModal.backgroundColor = .white
            respDosModal.textColor = .black
            respDosModal.isEditable = false
            
            respDosModal.isScrollEnabled = false
            self.respDosModal.font = .systemFont(ofSize: 20)
            imagenSiNo = true
            
            let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["respuestados"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
            let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
            
            imagenPreguntaMain = arrayPreguntas[contador]["respuestados"]!
            let imageView = UIImageView(image: image)
            
            imageView.image = UIImage(contentsOfFile: bundlePath!)
            
            // create an NSMutableAttributedString that we'll append everything to
            //let fullString = NSMutableAttributedString(string: "")
            let fullString = NSMutableAttributedString(string: "(2)  ")
            
            // create our NSTextAttachment
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(contentsOfFile: bundlePath!)
            
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            
            // add the NSTextAttachment wrapper to our full string, then add some more text.
            fullString.append(image1String)
            //fullString.append(NSAttributedString(string: "End of text"))
            
            // draw the result in a label
            self.respDosModal.attributedText = fullString
            
            var frame = self.respDosModal.frame
            frame.size.height = self.respDosModal.contentSize.height
            self.respDosModal.frame = frame
            
            self.view.addSubview(respDosModal)
            
            //Ajustando caja de contenido de la imagen
            
            respDosModal.isScrollEnabled = false
            
            respDosModal.translatesAutoresizingMaskIntoConstraints = true
            respDosModal.sizeToFit()
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respDosModal.frame.size.height + 5.0
            
            scrollView.addSubview(respDosModal)
            self.vistaPreguntas.addSubview(scrollView)
            //self.vistaPreguntas.addSubview(respDosModal)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }else{
            
            respDosModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta, height: 100.0))
            respDosModal.backgroundColor = .white
            respDosModal.textColor = .black
            respDosModal.isEditable = false
            
            imagenSiNo = false
            respDosModal.text = "(2) " + arrayPreguntas[contador]["respuestados"]!.trimmingCharacters(in: .whitespaces)
            
            self.respDosModal.font = .systemFont(ofSize: 20)
            
            respDosModal.isScrollEnabled = false
            
            respDosModal.translatesAutoresizingMaskIntoConstraints = true
            respDosModal.sizeToFit()
            
            let fixedWidth = respDosModal.frame.size.width
            
            let newSize = respDosModal.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respDosModal.frame.size.height + 5.0
            
            respDosModal.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            //self.vistaPreguntas.addSubview(respDosModal)
            scrollView.addSubview(respDosModal)
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }
        
        
        if(arrayPreguntas[contador]["respuestatres"]!.contains(".PNG") ||
            arrayPreguntas[contador]["respuestatres"]!.contains(".png")){
            
            respTresModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta, height: 100.0))
            respTresModal.backgroundColor = .white
            respTresModal.textColor = .black
            respTresModal.isEditable = false
            
            respTresModal.isScrollEnabled = false
            self.respTresModal.font = .systemFont(ofSize: 20)
            imagenSiNo = true
            
            let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["respuestatres"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
            let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
            
            imagenPreguntaMain = arrayPreguntas[contador]["respuestatres"]!
            let imageView = UIImageView(image: image)
            
            imageView.image = UIImage(contentsOfFile: bundlePath!)
            
            // create an NSMutableAttributedString that we'll append everything to
            //let fullString = NSMutableAttributedString(string: "")
            let fullString = NSMutableAttributedString(string: "(1)  ")
            
            // create our NSTextAttachment
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(contentsOfFile: bundlePath!)
            
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            
            // add the NSTextAttachment wrapper to our full string, then add some more text.
            fullString.append(image1String)
            //fullString.append(NSAttributedString(string: "End of text"))
            
            // draw the result in a label
            self.respTresModal.attributedText = fullString
            
            var frame = self.respTresModal.frame
            frame.size.height = self.respTresModal.contentSize.height
            self.respTresModal.frame = frame
            
            self.view.addSubview(respTresModal)
            
            //Ajustando caja de contenido de la imagen
            
            respTresModal.isScrollEnabled = false
            
            respTresModal.translatesAutoresizingMaskIntoConstraints = true
            respTresModal.sizeToFit()
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respTresModal.frame.size.height + 5.0
            
            //self.vistaPreguntas.addSubview(respTresModal)
            scrollView.addSubview(respTresModal)
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }else{
            
            respTresModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta, height: 100.0))
            respTresModal.backgroundColor = .white
            respTresModal.textColor = .black
            respTresModal.isEditable = false
            
            imagenSiNo = false
            respTresModal.text = "(3) " + arrayPreguntas[contador]["respuestatres"]!.trimmingCharacters(in: .whitespaces)
            
            self.respTresModal.font = .systemFont(ofSize: 20)
            
            respTresModal.isScrollEnabled = false
            
            respTresModal.translatesAutoresizingMaskIntoConstraints = true
            respTresModal.sizeToFit()
            
            let fixedWidth = respTresModal.frame.size.width
            
            let newSize = respTresModal.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respTresModal.frame.size.height + 5.0
            
            respTresModal.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            //self.vistaPreguntas.addSubview(respTresModal)
            scrollView.addSubview(respTresModal)
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }
        
        
        if(arrayPreguntas[contador]["respuestacuatro"]!.contains(".PNG") ||
            arrayPreguntas[contador]["respuestacuatro"]!.contains(".png")){
            
            respCuatroModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta, height: 100.0))
            respCuatroModal.backgroundColor = .white
            respCuatroModal.textColor = .black
            respCuatroModal.isEditable = false
            
            respCuatroModal.isScrollEnabled = false
            self.respCuatroModal.font = .systemFont(ofSize: 20)
            imagenSiNo = true
            
            let bundlePath = Bundle.main.path(forResource: arrayPreguntas[contador]["respuestacuatro"]!.trimmingCharacters(in: .whitespaces), ofType: nil)
            
            let image: UIImage = UIImage(contentsOfFile: bundlePath!)!
            
            imagenPreguntaMain = arrayPreguntas[contador]["respuestacuatro"]!
            let imageView = UIImageView(image: image)
            
            imageView.image = UIImage(contentsOfFile: bundlePath!)
            
            // create an NSMutableAttributedString that we'll append everything to
            //let fullString = NSMutableAttributedString(string: "")
            let fullString = NSMutableAttributedString(string: "(4)  ")
            
            // create our NSTextAttachment
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(contentsOfFile: bundlePath!)
            
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            
            // add the NSTextAttachment wrapper to our full string, then add some more text.
            fullString.append(image1String)
            //fullString.append(NSAttributedString(string: "End of text"))
            
            // draw the result in a label
            self.respCuatroModal.attributedText = fullString
            
            var frame = self.respCuatroModal.frame
            frame.size.height = self.respCuatroModal.contentSize.height
            self.respCuatroModal.frame = frame
            
            self.view.addSubview(respCuatroModal)
            
            //Ajustando caja de contenido de la imagen
            
            respCuatroModal.isScrollEnabled = false
            
            respCuatroModal.translatesAutoresizingMaskIntoConstraints = true
            respCuatroModal.sizeToFit()
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respCuatroModal.frame.size.height + 50.0
            
            //self.vistaPreguntas.addSubview(respCuatroModal)
            scrollView.addSubview(respCuatroModal)
            
            let button = UIButton()
            button.frame = CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 20.0, height: 30)
            button.backgroundColor = UIColor.red
            button.setTitle("Cerrar", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            scrollView.addSubview(button)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + 50.0
            
            scrollView.contentSize = CGSize(width: tamanoPantallaXPregunta, height: tamanoPantallaYPregunta)
            
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }else{
            
            respCuatroModal = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta, height: 100.0))
            respCuatroModal.backgroundColor = .white
            respCuatroModal.textColor = .black
            respCuatroModal.isEditable = false
            
            imagenSiNo = false
            respCuatroModal.text = "(4) " + arrayPreguntas[contador]["respuestacuatro"]!.trimmingCharacters(in: .whitespaces)
            
            self.respCuatroModal.font = .systemFont(ofSize: 20)
            
            respCuatroModal.isScrollEnabled = false
            
            respCuatroModal.translatesAutoresizingMaskIntoConstraints = true
            respCuatroModal.sizeToFit()
            
            let fixedWidth = respCuatroModal.frame.size.width
            
            let newSize = respCuatroModal.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + respCuatroModal.frame.size.height + 50.0
            
            respCuatroModal.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            
            //self.vistaPreguntas.addSubview(respCuatroModal)
            scrollView.addSubview(respCuatroModal)
            
            
            let button = UIButton()
            button.frame = CGRect(x: 10.0, y: tamanoPantallaYPregunta, width: tamanoPantallaXPregunta - 20.0, height: 30)
            button.backgroundColor = UIColor.red
            button.setTitle("Cerrar", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            scrollView.addSubview(button)
            
            tamanoPantallaYPregunta = tamanoPantallaYPregunta + 50.0
            
            scrollView.contentSize = CGSize(width: tamanoPantallaXPregunta, height: tamanoPantallaYPregunta)
            
            self.vistaPreguntas.addSubview(scrollView)
            
            vistaPreguntas.center = view.center
            self.view.addSubview(vistaPreguntas)
            
        }
        
        
        
        /*
         var : UITextView!
         var : UITextView!*/
        
        /*var frame = self.preguntaMainPincipal.frame
         frame.size.height = self.preguntaMainPincipal.contentSize.height
         self.preguntaMainPincipal.frame = frame
         
         var frame2 = self.pregImageInstrucciones.frame
         frame2.size.height = self.pregImageInstrucciones.contentSize.height
         self.pregImageInstrucciones.frame = frame2*/
        
        /*   arrayRespuestas = []
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
         }*/
        
        
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        stopTimerTest()
        self.vistaPreguntas.removeFromSuperview()
        iniciaJuego()
    }
    
    @objc func buttonActionCerrar(sender: UIButton!) {
        stopTimerTest()
        //self.iniciaJuego()
        self.vistaTooltip.removeFromSuperview()
        print("Button Cerrar pregunta")
        let totalPreguntasInt = (numPreguntas! as NSString).integerValue - 1
        print("totalPreguntasInt \(totalPreguntasInt)")
        print("contador \(contador)")
        
        if(totalPreguntasInt == contador){
            self.performSegue(withIdentifier: "showResults", sender: self)
        }else{
            print("SIGUIENTE PREGUNTA")
            contador = contador + 1
            siguienteShowPreguntaNext()
            //pregunta()
            //reloadTabla()
        }
    }
    
    func siguientePreguntaNext(respuestaUser text: String) {
        
        respueta = text
        //soloCierra = "No"
        if(respueta != ""){
            
            /*   let start = respueta.index(respueta.startIndex, offsetBy: 0)
             let end = respueta.index(respueta.endIndex, offsetBy: -4)
             let range = start..<end
             
             let mySubstring = respueta[range]
             
             let myString = String(mySubstring)
             
             if(respueta.contains(".PNG")){
             respueta = String(myString)
             }
             if(respueta.contains(".png")){
             respueta = String(myString)
             }
             
             print("respuetanextCuestion \(respueta)")
             print("correctanextCuestion \(correcta)")
             
             if(respueta.trimmingCharacters(in: .whitespaces) == correcta.trimmingCharacters(in: .whitespaces)){*/
            
            for view in vistaTooltip.subviews{
                if(!view.contains(encabezadoAyuda)){
                    view.removeFromSuperview()
                }
            }
            
            tamanoPantallaXTooltip = vistaTooltip.frame.size.width
            tamanoPantallaYTooltipp = vistaTooltip.frame.size.height
            tamanoPantallaYTooltippAcomoda = 10.0
            
            var scrollView: UIScrollView!
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: tamanoPantallaXTooltip, height: tamanoPantallaYTooltipp))
            scrollView.contentSize = CGSize(width: tamanoPantallaXPregunta, height: 2000)
            
            respCorrectaTooltipp = UITextView(frame: CGRect(x: 10.0, y: 50.0, width: tamanoPantallaXTooltip - 50.0 , height: 100.0))
            respCorrectaTooltipp.backgroundColor = .white
            respCorrectaTooltipp.textColor = .black
            
            respCorrectaTooltipp.isUserInteractionEnabled = false
            
            if(respueta=="Si"){
                
                encabezadoAyuda.text = "RESPUESTA CORRECTA"
                
                contadorCorrectas = contadorCorrectas + 1
                
                aciertos.text = "Aciertos: \(contadorCorrectas)"
                aciertos.textColor = .white
                aciertos.textAlignment = .center
                
                //explicacionTooltipp.text = "Has logrado: \(contadorCorrectas) aciertos"
                //scrollView.addSubview(explicacionTooltipp)
                
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
                self.respCorrectaTooltipp.attributedText = fullString
                self.respCorrectaTooltipp.font = .systemFont(ofSize: 20)
                
                var frame = self.respCorrectaTooltipp.frame
                frame.size.height = self.respCorrectaTooltipp.contentSize.height
                self.respCorrectaTooltipp.frame = frame
                
                tamanoPantallaYTooltippAcomoda = frame.width + 100.0
                
                scrollView.addSubview(respCorrectaTooltipp)
                
                let button = UIButton()
                button.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltip - 20.0, height: 30)
                button.backgroundColor = UIColor.red
                button.setTitle("Cerrar", for: .normal)
                button.addTarget(self, action: #selector(buttonActionCerrar(sender:)), for: .touchUpInside)
                
                scrollView.addSubview(button)
                
                self.vistaTooltip.addSubview(scrollView)
                
                vistaTooltip.center = view.center
                self.view.addSubview(vistaTooltip)
                
            }else{
                
                encabezadoAyuda.text = "INCORRECTA"
                
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
                    self.respCorrectaTooltipp.attributedText = fullString
                    
                    
                    self.respCorrectaTooltipp.font = .systemFont(ofSize: 20)
                    var frame = self.respCorrectaTooltipp.frame
                    frame.size.height = self.respCorrectaTooltipp.contentSize.height
                    self.respCorrectaTooltipp.frame = frame
                    
                    let fixedWidth = respCorrectaTooltipp.frame.size.width
                    
                    let newSize = respCorrectaTooltipp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                    
                    respCorrectaTooltipp.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                    
                    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + respCorrectaTooltipp.frame.size.height + 50.0
                    
                    scrollView.addSubview(respCorrectaTooltipp)
                    
                    self.vistaTooltip.addSubview(scrollView)
                    
                    
                }else{
                    respCorrectaTooltipp.text = "Respuesta Correcta: " + correcta
                    
                    self.respCorrectaTooltipp.font = .systemFont(ofSize: 20)
                    let fixedWidth = respCorrectaTooltipp.frame.size.width
                    
                    let newSize = respCorrectaTooltipp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                    
                    respCorrectaTooltipp.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                    
                    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + respCorrectaTooltipp.frame.size.height + 50.0
                    
                    scrollView.addSubview(respCorrectaTooltipp)
                    
                    self.vistaTooltip.addSubview(scrollView)
                }
                
                if(imagenTooltip.contains(".PNG") || imagenTooltip.contains(".png")){
                    // create an NSMutableAttributedString that we'll append everything to
                    
                    explicacionTooltipp = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltip - 20.0 , height: 100.0))
                    explicacionTooltipp.backgroundColor = .white
                    explicacionTooltipp.textColor = .black
                    
                    explicacionTooltipp.isUserInteractionEnabled = false
                    
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
                    self.explicacionTooltipp.attributedText = fullString
                    
                    self.explicacionTooltipp.font = .systemFont(ofSize: 20)
                    
                    var frame = self.explicacionTooltipp.frame
                    frame.size.height = self.explicacionTooltipp.contentSize.height
                    self.explicacionTooltipp.frame = frame
                    
                    let fixedWidth = explicacionTooltipp.frame.size.width
                    
                    let newSize = explicacionTooltipp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                    
                    explicacionTooltipp.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                    
                    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + explicacionTooltipp.frame.size.height + 5.0
                    
                    scrollView.addSubview(explicacionTooltipp)
                    
                    self.vistaTooltip.addSubview(scrollView)
                    
                    
                }else{
                    
                    explicacionTooltipp = UITextView(frame: CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltip - 20.0 , height: 100.0))
                    explicacionTooltipp.backgroundColor = .white
                    explicacionTooltipp.textColor = .black
                    
                    explicacionTooltipp.isUserInteractionEnabled = false
                    
                    explicacionTooltipp.text = tooltip
                    
                    self.explicacionTooltipp.font = .systemFont(ofSize: 20)
                    let fixedWidth = explicacionTooltipp.frame.size.width
                    
                    let newSize = explicacionTooltipp.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                    
                    explicacionTooltipp.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                    
                    tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + explicacionTooltipp.frame.size.height + 5.0
                    
                    scrollView.addSubview(explicacionTooltipp)
                    
                    self.vistaTooltip.addSubview(scrollView)
                }
                
                scrollView.addSubview(explicacionTooltipp)
                
                let button = UIButton()
                button.frame = CGRect(x: 10.0, y: tamanoPantallaYTooltippAcomoda, width: tamanoPantallaXTooltip - 20.0, height: 30)
                button.backgroundColor = UIColor.red
                button.setTitle("Cerrar", for: .normal)
                button.addTarget(self, action: #selector(buttonActionCerrar), for: .touchUpInside)
                
                scrollView.addSubview(button)
                
                let fixedWidth = scrollView.frame.size.width
                
                let newSize = scrollView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                
                scrollView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
                
                tamanoPantallaYTooltippAcomoda = tamanoPantallaYTooltippAcomoda + 50.0
                
                scrollView.contentSize = CGSize(width: tamanoPantallaXTooltip, height: tamanoPantallaYTooltippAcomoda)
                
                self.vistaTooltip.addSubview(scrollView)
                
                vistaTooltip.center = view.center
                self.view.addSubview(vistaTooltip)
            }
            
        }else{
            
            let alert = UIAlertController(title: "Perdiste", message: "¡Destruyeron tu avión!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                    let totalPreguntasInt = (self.numPreguntas! as NSString).integerValue - 1
                    print("totalPreguntasInt \(totalPreguntasInt)")
                    print("contador \(self.contador)")
                    self.iniciaJuego()
                    self.siguienteShowPreguntaNext()
                    /* if(totalPreguntasInt == self.contador){
                     self.performSegue(withIdentifier: "muestraResultados", sender: self)
                     }else{
                     self.contador = self.contador + 1
                     //self.pregunta()
                     
                     //if(self.arrayPreguntas[self.contador]["respuestauno"]!.contains(".PNG") ||
                     //self.arrayPreguntas[self.contador]["respuestauno"]!.contains(".png")){
                     print("respuestaUno: \(self.arrayPreguntas[self.contador]["respuestauno"]!)")
                     self.iniciaJuego()
                     //  }
                     }*/
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }
            }))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @objc func handleApplicationWillResignActive (_ note: Notification) {
        let skView = vistaJuego as! SKView
        skView.isPaused = true
    }
    
    @objc func handleApplicationDidBecomeActive (_ note: Notification) {
        let skView = vistaJuego as! SKView
        skView.isPaused = false
    }
    
    
    
    /*   func muestraRespuestas(numPreg : String) -> [[String:String]]{
     
     print("Consulta")
     return arrayPreguntas as [[String:String]]
     
     }*/
    
    func muestraRespuestas() -> [String]{
        
        let respImaView = [
            arrayPreguntas[contador]["pregunta"]!, //0
            arrayPreguntas[contador]["imagenpregunta"]!, //1
            arrayPreguntas[contador]["respuestauno"]!, //2
            arrayPreguntas[contador]["respuestados"]!, //3
            arrayPreguntas[contador]["respuestatres"]!, //4
            arrayPreguntas[contador]["respuestacuatro"]!, //5
            arrayPreguntas[contador]["correcta"]!, //6
            arrayPreguntas[contador]["tooltip"]!, //7
            arrayPreguntas[contador]["imagentooltip"]! //8
        ]
        
        print("respImaView")
        
        return respImaView
        
    }
    
    
    func obtenNumRespCorrecta() -> String{
        
        var respImaView:String!
        
        if(arrayPreguntas[contador]["respuestauno"]!.trimmingCharacters(in: .whitespaces) == arrayPreguntas[contador]["correcta"]!.trimmingCharacters(in: .whitespaces)){
            respImaView = "Uno"
        }
        if(arrayPreguntas[contador]["respuestados"]!.trimmingCharacters(in: .whitespaces) == arrayPreguntas[contador]["correcta"]!.trimmingCharacters(in: .whitespaces)){
            respImaView = "Dos"
        }
        if(arrayPreguntas[contador]["respuestatres"]!.trimmingCharacters(in: .whitespaces) == arrayPreguntas[contador]["correcta"]!.trimmingCharacters(in: .whitespaces)){
            respImaView = "Tres"
        }
        if(arrayPreguntas[contador]["respuestacuatro"]!.trimmingCharacters(in: .whitespaces) == arrayPreguntas[contador]["correcta"]!.trimmingCharacters(in: .whitespaces)){
            respImaView = "Cuatro"
        }
        
        
        return respImaView
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showResults"{
            print("materia: \(materia!)")
            muestraInstruccion = false
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
