//
//  GameScene.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/13/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import SpriteKit
import CoreMotion

extension SKTexture
{
    var name : String
    {
        return self.description.slice(start: "'",to: "'")!
    }
}

extension String {
    func slice(start: String, to: String) -> String?
    {
        
        return (range(of: start)?.upperBound).flatMap
            {
                sInd in
                (range(of: to, range: sInd..<endIndex)?.lowerBound).map
                    {
                        eInd in
                        substring(with:sInd..<eInd)
                        
                }
        }
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Private GameScene Properties
    
    var gameDelegate: SKScene?
    
    let motionManager = CMMotionManager()
    
    var contentCreated = false
    
    // 1
    var invaderMovementDirection: InvaderMovementDirection = .right
    // 2
    var timeOfLastMove: CFTimeInterval = 0.0
    // 3
    var timePerMove: CFTimeInterval = 1.0
    
    var tapQueue = [Int]()
    var contactQueue = [SKPhysicsContact]()
    
    var score: Int = 0
    var shipHealth: Float = 1.0
    var invaderHealth: Float = 1.0
    
    let kMinInvaderBottomHeight: Float = 32.0
    var gameEnding: Bool = false
    
    enum InvaderType {
        case a
        case b
        case c
        case d
        
        static var size: CGSize {
            return CGSize(width: 24, height: 16)
        }
        
        static var name: String {
            return "invader"
        }
    }
    
    var runo: String = ""
    var rdos: String = ""
    var rtres: String = ""
    var rcuatro: String = ""
    
    var respuestas = [String]()
    var imagenesRespuesta:[String] = []
    var respuestasHealt = [Float]()
    var correcta: String = "rtresmateunampreguntadiez.png"
    
    
    enum InvaderMovementDirection {
        case right
        case left
        case downThenRight
        case downThenLeft
        case none
    }
    
    enum BulletType {
        case shipFired
        case invaderFired
    }
    
    let kInvaderGridSpacing = CGSize(width: 12, height: 12)
    let kInvaderRowCount = 4
    let kInvaderColCount = 6
    
    let kShipSize = CGSize(width: 30, height: 16)
    let kShipName = "ship"
    
    let kScoreHudName = "scoreHud"
    let kHealthHudName = "healthHud"
    
    let kShipFiredBulletName = "shipFiredBullet"
    let kInvaderFiredBulletName = "invaderFiredBullet"
    let kBulletSize = CGSize(width:4, height: 8)
    
    let kInvaderCategory: UInt32 = 0x1 << 0
    let kShipFiredBulletCategory: UInt32 = 0x1 << 1
    let kShipCategory: UInt32 = 0x1 << 2
    let kSceneEdgeCategory: UInt32 = 0x1 << 3
    let kInvaderFiredBulletCategory: UInt32 = 0x1 << 4
    
    // Object Lifecycle Management
    
    // Scene Setup and Content Creation
    
    var player = SKSpriteNode()
    var ship = SKSpriteNode(imageNamed: "naveuno.png")
    var nodePosition = CGPoint()
    var startTouch = CGPoint()
    var filename = ""
    var destruyeNave: Bool = false
    
    //Make a Timer
    
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        // timerLabel.text = “\(seconds)” //This will update the label.
        print("Tiempo: \(seconds)")
        if(seconds==58){
            timer.invalidate()
        }
    }
    
    //End Make a Timer
    
    //llamando metodos del viewcontroller
    
    var viewController: GameViewController!
    
    //fin llamando metodos del viewcontroller
    
    var backgroundImagen = SKSpriteNode(imageNamed: "backgroundfinal")
    
    override func didMove(to view: SKView) {
        
        //backgroundImagen.zPosition = 0
        //backgroundImagen.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        //addChild(background)
        gameEnding = false
        nuevsaPregunta()
        
        print("didMove")
        respuestas = [
            runo,
            rdos,
            rtres,
            rcuatro
        ]
        
        respuestasHealt = [
            1.0,
            1.0,
            1.0,
            1.0
        ]
        
        runTimer()
        
        startGame()
        
    }
    
    func startGame(){
        if (!self.contentCreated) {
            self.createContent()
            self.contentCreated = true
            motionManager.startAccelerometerUpdates()
            physicsWorld.contactDelegate = self
            
        }
    }
    
    
    var numRespCorrecta:String!
    
    func nuevsaPregunta(){
        //print("preg: \(self.viewController.muestraRespuestas(numPreg: "1") as! [String])")
        
        imagenesRespuesta = self.viewController.muestraRespuestas()
        print("imagenesRespuesta: \(imagenesRespuesta)")
        correcta = imagenesRespuesta[6]
        
        let numCorrecta = self.viewController.obtenNumRespCorrecta()
        numRespCorrecta = numCorrecta
        
        print("numRespCorrecta: \(numRespCorrecta!)")
        
    }
    
    func moveShip (moveBy: CGFloat, forTheKey: String) {
        let moveAction = SKAction.moveBy(x: moveBy, y: 0, duration: 1)
        let repeatForEver = SKAction.repeatForever(moveAction)
        let seq = SKAction.sequence([moveAction, repeatForEver])
        
        //run the action on your ship
        player.run(seq, withKey: forTheKey)
    }
    
    func touchDown(atPoint position : CGPoint) {
        
        let tamanoPantallaX = Float((view?.bounds.maxX)!)
        var tamanoPantallaY = Float((view?.bounds.maxY)!)
        tamanoPantallaY = tamanoPantallaY / 4
        
        print("tamanoPantallaX: \(tamanoPantallaX)")
        print("tamanoPantallaY: \(tamanoPantallaY)")
        
        if position.x < self.frame.midX
        {
            let moveX = SKAction.moveTo(x: self.frame.minX + CGFloat(tamanoPantallaX), duration: 0.1)
            ship.run(moveX)
            
        } else if position.x > self.frame.midX {
            let moveX = SKAction.moveTo(x: self.frame.maxX - CGFloat(tamanoPantallaX), duration: 0.1)
            ship.run(moveX)
        }
        if position.y < self.frame.midY
        {
            let moveY = SKAction.moveTo(y: self.frame.minY + CGFloat(tamanoPantallaY), duration: 0.1)
            ship.run(moveY)
            
        } else if position.x > self.frame.midX {
            let moveY = SKAction.moveTo(y: self.frame.maxY - CGFloat(tamanoPantallaY), duration: 0.1)
            ship.run(moveY)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tamanoPantalla = CGFloat((view?.bounds.maxX)!)
        
        print("tamanoPantalla: \(tamanoPantalla)")
        print("nodePosition.x: \(nodePosition.x)")
        print("nodePosition.y: \(nodePosition.y)")
        
        var tamanoPantallaY = Float((view?.bounds.maxY)!)
        tamanoPantallaY = tamanoPantallaY / 3
        
        let touch = touches.first
        if let location = touch?.location(in: self){
            ship.run(SKAction.move(to: CGPoint(x:  nodePosition.x + location.x - startTouch.x, y: nodePosition.y + CGFloat(tamanoPantallaY) - startTouch.y), duration: 0.1))
            /*if location.x < tamanoPantalla && location.y < 200{
             ship.run(SKAction.move(to: CGPoint(x:  nodePosition.x + location.x - startTouch.x, y: nodePosition.y + location.y - startTouch.y), duration: 0.1))
             }*/
            print("X \(nodePosition.x)")
            print("Y \(nodePosition.y)")
            print("locatoionX \(location.x)")
            print("locationY \(location.y)")
            print("starttouchX \(startTouch.x)")
            print("starttouchY \(startTouch.y)")
        }
    }
    
    
    
    /*  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     
     //       for t in touches { self.touchDown(atPoint: t.location(in: self)) }
     
     let tamanoPantalla = CGFloat((view?.bounds.maxX)!)
     
     print("tamanoPantalla: \(tamanoPantalla)")
     
     let touch = touches.first
     if let location = touch?.location(in: self){
     //    ship.run(SKAction.move(to: CGPoint(x:  nodePosition.x + location.x - startTouch.x, y: //nodePosition.y + location.y - startTouch.y), duration: 0.1))
     if location.x < tamanoPantalla && location.y < 200{
     ship.run(SKAction.move(to: CGPoint(x:  nodePosition.x + location.x - startTouch.x, y: nodePosition.y + location.y - startTouch.y), duration: 0.1))
     }
     print("X \(nodePosition.x)")
     print("Y \(nodePosition.y)")
     print("locatoionX \(location.x)")
     print("locationY \(location.y)")
     print("starttouchX \(startTouch.x)")
     print("starttouchY \(startTouch.y)")
     }
     
     
     }*/
    
    /*    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
     for t in touches { self.touchDown(atPoint: t.location(in: self)) }
     }*/
    
    func createContent() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody!.categoryBitMask = kSceneEdgeCategory
        
        //addChild(backgroundImagen)
        
        setupInvaders()
        setupShip()
        setupHud()
        
        // black space color
        let colorCielo = UIColor(red:102/255, green:102/255, blue:102/255, alpha:1.0)
        self.backgroundColor = .clear
        
        
    }
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 20)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedStringKey.font: textFont,
            NSAttributedStringKey.foregroundColor: textColor,
            ] as [NSAttributedStringKey : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func generateImageWithText(text: String) -> UIImage
    {
        let image = UIImage(named: "imageWithoutText.png")!
        
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor.clear
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = label.font.withSize(100)
        label.text = text
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }
    
    func loadInvaderTextures(ofType invaderType: InvaderType) -> [SKTexture] {
        
        /*  var prefix: String
         
         switch(invaderType) {
         case .a:
         prefix = "InvaderA"
         case .b:
         prefix = "InvaderB"
         case .c:
         prefix = "InvaderC"
         }
         
         // 1
         return [SKTexture(imageNamed: String(format: "%@_00.png", prefix)),
         SKTexture(imageNamed: String(format: "%@_01.png", prefix))]*/
        
        var prefix: String
        var prefixIKmagen: UIImage = UIImage(named: "imageWithoutText.png")!
        
        var imagenUno: UIImage
        var imagenDos: UIImage
        var imagenTres: UIImage
        var imagenCuatro: UIImage
        
        switch(invaderType) {
        case .a:
            prefix = "brainruno.png"
            respuestas[0] = prefix + ".png"
            /*prefix = imagenesRespuesta[2]
             if(imagenesRespuesta[2].contains(".png")){
             respuestas[0] = prefix + ".png"
             }else{
             respuestas[0] = prefix + ".PNG"
             }
             
             if(!imagenesRespuesta[2].contains(".png")){
             imagenUno = generateImageWithText(text: imagenesRespuesta[2])
             prefixIKmagen = imagenUno
             }*/
            
        case .b:
            prefix = "braindos.png"
            respuestas[1] = prefix + ".png"
            /*prefix = imagenesRespuesta[3]
             if(imagenesRespuesta[3].contains(".png")){
             respuestas[1] = prefix + ".png"
             }else{
             respuestas[1] = prefix + ".PNG"
             }
             
             if(!imagenesRespuesta[3].contains(".png")){
             imagenDos = generateImageWithText(text: imagenesRespuesta[3])
             
             prefixIKmagen = imagenDos
             }*/
            
            
        case .c:
            prefix = "brainrtres.png"
            respuestas[2] = prefix + ".png"
            /* prefix = imagenesRespuesta[4]
             if(imagenesRespuesta[4].contains(".png")){
             respuestas[2] = prefix + ".png"
             }else{
             respuestas[2] = prefix + ".PNG"
             }
             
             if(!imagenesRespuesta[4].contains(".png")){
             imagenTres = generateImageWithText(text: imagenesRespuesta[4])
             
             prefixIKmagen = imagenTres
             }*/
            
            
        case .d:
            prefix = "brainrcuatro.png"
            respuestas[3] = prefix + ".png"
            /*   prefix = imagenesRespuesta[5]
             if(imagenesRespuesta[5].contains(".png")){
             respuestas[3] = prefix + ".png"
             }else{
             respuestas[3] = prefix + ".PNG"
             }
             if(!imagenesRespuesta[5].contains(".png")){
             imagenCuatro = generateImageWithText(text: imagenesRespuesta[5])
             
             prefixIKmagen = imagenCuatro
             
             }*/
            
            
        }
        
        // print("prefixIKmagen: \(prefixIKmagen)")
        
        var texturas: [SKTexture] = [SKTexture(imageNamed: String(format: "%@.png", prefix)),
                                     SKTexture(imageNamed: String(format: "%@.PNG", prefix))]
        
        if(prefix.contains(".png") || prefix.contains(".PNG")){
            texturas = [SKTexture(imageNamed: String(format: "%@.png", prefix)),
                        SKTexture(imageNamed: String(format: "%@.PNG", prefix))]
        }else{
            let titleLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
            titleLabel.fontSize = 20
            titleLabel.fontColor = SKColor.blue
            titleLabel.text = prefix
            titleLabel.horizontalAlignmentMode = .center
            titleLabel.zPosition = 5
            titleLabel.blendMode = .subtract
            
            /*  texturas = [SKTexture(image: prefixIKmagen),
             SKTexture(image: prefixIKmagen)]*/
            
            texturas = [SKTexture(imageNamed: String(format: "%@.png", prefixIKmagen)),
                        SKTexture(imageNamed: String(format: "%@.PNG", prefixIKmagen))]
            
        }
        // 1
        return texturas
        
    }
    
    
    
    func makeInvader(ofType invaderType: InvaderType) -> SKNode {
        
        let invaderTextures = loadInvaderTextures(ofType: invaderType)
        // 2
        let invader = SKSpriteNode(texture: invaderTextures[0])
        let nameInvader = SKSpriteNode(texture: invaderTextures[0])
        
        filename = nameInvader.texture!.name
        print("filename: \(filename)")
        
        //  invader.name = InvaderType.name
        invader.name = filename
        
        let rotate = SKAction.rotate(toAngle: 1.5555, duration: 2, shortestUnitArc: true)
        //let rotate = SKAction.rotate(toAngle: 0.0, duration: 10, shortestUnitArc: true)
        let repeatRotation = SKAction.repeat(rotate, count: 1)
        invader.run(repeatRotation)
        // 3
        invader.run(SKAction.repeatForever(SKAction.animate(with: invaderTextures, timePerFrame: timePerMove)))
        
        // invaders' bitmasks setup
        invader.physicsBody = SKPhysicsBody(rectangleOf: invader.frame.size)
        invader.physicsBody!.isDynamic = false
        invader.physicsBody!.categoryBitMask = kInvaderCategory
        invader.physicsBody!.contactTestBitMask = 0x0
        invader.physicsBody!.collisionBitMask = 0x0
        
        invader.size.height = 80
        invader.size.width = 80
        
        var tamanoRespuestaX = invader.size.width
        var tamanoRespuestaY = invader.size.height
        
        /*  if(tamanoRespuestaX <= 80){
         print("tamanoRespuestaX: \(tamanoRespuestaX*2)")
         invader.size.width = 80
         }else if(tamanoRespuestaX > 80){
         invader.size.width = 120
         }
         if(tamanoRespuestaY < 40){
         print("tamanoRespuestaY: \(tamanoRespuestaY*2)")
         invader.size.height = 40
         }else if(tamanoRespuestaY > 40){
         invader.size.height = 60
         }*/
        
        tamanoRespuestaX = invader.size.width
        tamanoRespuestaY = invader.size.height
        
        print("tamanoRespuestaX-DEsp: \(tamanoRespuestaX)")
        print("tamanoRespuestaY-DEsp: \(tamanoRespuestaY)")
        
        return invader
    }
    
    
    func setupInvaders() {
        // 1
        // let baseOrigin = CGPoint(x: size.width / 3, y: size.height / 2)
        let baseOrigin = CGPoint(x: size.height / 2, y: size.width / 3)
        
        let newOrigin = baseOrigin.x + (baseOrigin.x / 2)
        
        for row in 0..<kInvaderRowCount {
            // 2
            var invaderType: InvaderType
            
            if row == 0 {
                invaderType = .a
                print("baseOrigin.a: \(newOrigin)")
            } else if row == 1 {
                invaderType = .b
                //   newOrigin = newOrigin + InvaderType.size.height * 4
                print("baseOrigin.b: \(newOrigin)")
            } else if row == 2 {
                invaderType = .c
                //   newOrigin = newOrigin + InvaderType.size.height * 4
                print("baseOrigin.c: \(newOrigin)")
            } else {
                invaderType = .d
                //   newOrigin = newOrigin + InvaderType.size.height * 4
                print("baseOrigin.d: \(newOrigin)")
            }
            
            // 3
            let invaderPositionY = CGFloat(row) * (InvaderType.size.width * 2.5) + baseOrigin.y
            
            // var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
            var invaderPosition = CGPoint(x: invaderPositionY, y: newOrigin)
            
            print("invaderPosition: \(invaderPosition)")
            
            // 4
            // for _ in 1..<kInvaderRowCount {
            // 5
            let invader = makeInvader(ofType: invaderType)
            invader.position = invaderPosition
            
            addChild(invader)
            
            invaderPosition = CGPoint(
                x: invaderPosition.x + InvaderType.size.width + kInvaderGridSpacing.width,
                y: invaderPositionY
            )
            //}
        }
    }
    
    func setupShip() {
        // 1
        let ship = makeShip()
        
        let baseOrigin = CGPoint(x: size.height / 2, y: size.width / 3)
        
        let newOrigin = baseOrigin.x
        
        // 2
        ship.position = CGPoint(x: size.width / 2.0, y: newOrigin)
        addChild(ship)
    }
    
    func makeShip() -> SKNode {
        
        ship.name = kShipName
        
        // 1
        ship.physicsBody = SKPhysicsBody(rectangleOf: ship.frame.size)
        
        // 2
        ship.physicsBody!.isDynamic = true
        
        // 3
        ship.physicsBody!.affectedByGravity = false
        
        // 4
        ship.physicsBody!.mass = 0.02
        
        // 1
        ship.physicsBody!.categoryBitMask = kShipCategory
        // 2
        ship.physicsBody!.contactTestBitMask = 0x0
        // 3
        ship.physicsBody!.collisionBitMask = kSceneEdgeCategory
        
        //  ship.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        //  self.addChild(player)
        
        return ship
    }
    
    func setupHud() {
        // 1
        let scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.name = kScoreHudName
        scoreLabel.fontSize = 25
        
        // 2
        scoreLabel.fontColor = SKColor.green
        //scoreLabel.text = String(format: "Score: %04u", 0)
        scoreLabel.text = String(format: "Wait: %04u", seconds)
        
        if(seconds==58){
            scoreLabel.text = ""
        }
        
        // 3
        scoreLabel.position = CGPoint(
            x: frame.size.width / 2,
            y: size.height - (140 + scoreLabel.frame.size.height/2)
        )
        //addChild(scoreLabel)
        
        // 4
        let healthLabel = SKLabelNode(fontNamed: "Courier")
        healthLabel.name = kHealthHudName
        healthLabel.fontSize = 25
        
        // 5
        healthLabel.fontColor = SKColor.red
        healthLabel.text = String(format: "Health: %.1f%%", shipHealth * 100.0)
        
        // 6
        healthLabel.position = CGPoint(
            x: frame.size.width / 2,
            y: size.height - (180 + healthLabel.frame.size.height/2)
        )
        //addChild(healthLabel)
    }
    
    func adjustScore(by points: Int) {
        score += points
        
        if let score = childNode(withName: kScoreHudName) as? SKLabelNode {
            score.text = String(format: "Score: %04u", self.score)
            
        }
    }
    
    func adjustShipHealth(by healthAdjustment: Float) {
        // 1
        shipHealth = max(shipHealth + healthAdjustment, 0)
        
        if let health = childNode(withName: kHealthHudName) as? SKLabelNode {
            health.text = String(format: "Health: %.1f%%", self.shipHealth * 100)
        }
    }
    
    func adjustInvaderHealth(by healthAdjustment: Float, nombreInvader: Float) {
        // 1
        invaderHealth = max(invaderHealth + healthAdjustment, 0)
        
    }
    
    func makeBullet(ofType bulletType: BulletType) -> SKNode {
        var bullet: SKNode
        
        switch bulletType {
        case .shipFired:
            bullet = SKSpriteNode(color: SKColor.green, size: kBulletSize)
            bullet.name = kShipFiredBulletName
            
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
            bullet.physicsBody!.isDynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kShipFiredBulletCategory
            bullet.physicsBody!.contactTestBitMask = kInvaderCategory
            bullet.physicsBody!.collisionBitMask = 0x0
        case .invaderFired:
            bullet = SKSpriteNode(color: SKColor.magenta, size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
            
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size)
            bullet.physicsBody!.isDynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.categoryBitMask = kInvaderFiredBulletCategory
            bullet.physicsBody!.contactTestBitMask = kShipCategory
            bullet.physicsBody!.collisionBitMask = 0x0
            break
        }
        
        return bullet
    }
    
    // Scene Update
    
    func moveInvaders(forUpdate currentTime: CFTimeInterval) {
        // 1
        if (currentTime - timeOfLastMove < timePerMove) {
            return
        }
        
        for i in 0..<respuestas.count {
            
            determineInvaderMovementDirection()
            
            // 2
            enumerateChildNodes(withName: respuestas[i]) { node, stop in
                switch self.invaderMovementDirection {
                case .right:
                    node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
                case .left:
                    node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
                case .downThenLeft, .downThenRight:
                    node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
                case .none:
                    break
                }
                
                // 3
                self.timeOfLastMove = currentTime
            }
            
            
        }
    }
    
    func adjustInvaderMovement(to timePerMove: CFTimeInterval) {
        // 1
        if self.timePerMove <= 0 {
            return
        }
        
        // 2
        let ratio: CGFloat = CGFloat(self.timePerMove / timePerMove)
        self.timePerMove = timePerMove
        
        // 3
        
        for i in 0..<respuestas.count {
            enumerateChildNodes(withName: respuestas[i]) { node, stop in
                node.speed = node.speed * ratio
            }
            
            
        }
    }
    
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        // 1
        if let ship = childNode(withName: kShipName) as? SKSpriteNode {
            // 2
            if let data = motionManager.accelerometerData {
                // 3
                if fabs(data.acceleration.x) > 0.2 {
                    // 4 How do you move the ship?
                    print("Acceleration: \(data.acceleration.x)")
                    ship.physicsBody!.applyForce(CGVector(dx: 40 * CGFloat(data.acceleration.x), dy: 0))
                }
            }
        }
    }
    
    func fireInvaderBullets(forUpdate currentTime: CFTimeInterval) {
        let existingBullet = childNode(withName: kInvaderFiredBulletName)
        
        // 1
        if existingBullet == nil {
            var allInvaders = [SKNode]()
            
            // 2
            
            for i in 0..<respuestas.count {
                enumerateChildNodes(withName: respuestas[i]) { node, stop in
                    allInvaders.append(node)
                }
            }
            
            if allInvaders.count > 0 {
                // 3
                let allInvadersIndex = Int(arc4random_uniform(UInt32(allInvaders.count)))
                
                let invader = allInvaders[allInvadersIndex]
                
                // 4
                let bullet = makeBullet(ofType: .invaderFired)
                bullet.position = CGPoint(
                    x: invader.position.x,
                    y: invader.position.y - invader.frame.size.height / 2 + bullet.frame.size.height / 2
                )
                
                // 5
                let bulletDestination = CGPoint(x: invader.position.x, y: -(bullet.frame.size.height / 2))
                
                // 6
                fireBullet(
                    bullet: bullet,
                    toDestination: bulletDestination,
                    withDuration: 1.2,
                    //andSoundFileName: "InvaderBullet.wav"
                    andSoundFileName: ""
                )
            }
        }
    }
    
    func processContacts(forUpdate currentTime: CFTimeInterval) {
        for contact in contactQueue {
            handle(contact)
            if let index = contactQueue.index(of: contact) {
                contactQueue.remove(at: index)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
        if isGameOver() {
            //if(gameEnding){
            if let score = childNode(withName: kScoreHudName) as? SKLabelNode {
                score.text = String(format: "Respuesta correcta", self.score)
            }
            
            endGame()
        }
        
        if(seconds<=58 && gameEnding==false){
            
            processUserMotion(forUpdate: currentTime)
            moveInvaders(forUpdate: currentTime)
            processUserTaps(forUpdate: currentTime)
            fireInvaderBullets(forUpdate: currentTime)
            processContacts(forUpdate: currentTime)
        }
        
        
    }
    
    // Scene Update Helpers
    
    func processUserTaps(forUpdate currentTime: CFTimeInterval) {
        // 1
        for tapCount in tapQueue {
            if tapCount == 1 {
                // 2
                print("dispara")
                fireShipBullets()
            }
            // 3
            print("tapQueue: \(tapQueue)")
            tapQueue.remove(at: 0)
        }
    }
    
    // Invader Movement Helpers
    
    func determineInvaderMovementDirection() {
        // 1
        var proposedMovementDirection: InvaderMovementDirection = invaderMovementDirection
        
        // 2
        
        for i in 0..<respuestas.count {
            enumerateChildNodes(withName: respuestas[i]) { node, stop in
                
                switch self.invaderMovementDirection {
                case .right:
                    //3
                    if (node.frame.maxX >= node.scene!.size.width - 1.0) {
                        proposedMovementDirection = .downThenLeft
                        
                        // Add the following line
                        self.adjustInvaderMovement(to: self.timePerMove * 0.8)
                        
                        stop.pointee = true
                    }
                case .left:
                    //4
                    if (node.frame.minX <= 1.0) {
                        proposedMovementDirection = .downThenRight
                        
                        // Add the following line
                        self.adjustInvaderMovement(to: self.timePerMove * 0.8)
                        
                        stop.pointee = true
                    }
                    
                case .downThenLeft:
                    proposedMovementDirection = .left
                    
                    stop.pointee = true
                    
                case .downThenRight:
                    proposedMovementDirection = .right
                    
                    stop.pointee = true
                    
                default:
                    break
                }
                
            }
            //7
            if (proposedMovementDirection != invaderMovementDirection) {
                invaderMovementDirection = proposedMovementDirection
            }
            
        }
        
        
        
    }
    
    // Bullet Helpers
    
    func fireBullet(bullet: SKNode, toDestination destination: CGPoint, withDuration duration: CFTimeInterval, andSoundFileName soundName: String) {
        // 1
        
        let bulletAction = SKAction.sequence([
            SKAction.move(to: destination, duration: duration),
            SKAction.wait(forDuration: 3.0 / 60.0),
            SKAction.removeFromParent()
            ])
        
        // 2
        //let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        
        // 3
        //bullet.run(SKAction.group([bulletAction, soundAction]))
        bullet.run(SKAction.group([bulletAction]))
        
        // 4
        addChild(bullet)
    }
    
    func fireShipBullets() {
        let existingBullet = childNode(withName: kShipFiredBulletName)
        
        // 1
        if existingBullet == nil {
            if let ship = childNode(withName: kShipName) {
                let bullet = makeBullet(ofType: .shipFired)
                // 2
                bullet.position = CGPoint(
                    x: ship.position.x,
                    y: ship.position.y + ship.frame.size.height - bullet.frame.size.height / 2
                )
                // 3
                let bulletDestination = CGPoint(
                    x: ship.position.x,
                    y: frame.size.height + bullet.frame.size.height / 2
                )
                // 4
                
                fireBullet(
                    bullet: bullet,
                    toDestination: bulletDestination,
                    withDuration: 1.0,
                    //andSoundFileName: "ShipBullet.wav"
                    andSoundFileName: ""
                )
            }
        }
    }
    
    // User Tap Helpers
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (touch.tapCount == 1) {
                tapQueue.append(1)
            }
        }
    }
    
    // HUD Helpers
    
    // Physics Contact Helpers
    
    func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }
    
    func handle(_ contact: SKPhysicsContact) {
        // Ensure you haven't already handled this contact and removed its nodes
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil {
            return
        }
        
        let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        
        if nodeNames.contains(kShipName) && nodeNames.contains(kInvaderFiredBulletName) {
            // Invader bullet hit a ship
            //run(SKAction.playSoundFileNamed("ShipHit.wav", waitForCompletion: false))
            
            // 1
            adjustShipHealth(by: -0.334)
            
            if shipHealth <= 0.0 {
                // 2
                destruyeNave = true
                contact.bodyA.node!.removeFromParent()
                contact.bodyB.node!.removeFromParent()
            } else {
                // 3
                if let ship = childNode(withName: kShipName) {
                    ship.alpha = CGFloat(shipHealth)
                    if contact.bodyA.node == ship {
                        contact.bodyB.node!.removeFromParent()
                    } else {
                        contact.bodyA.node!.removeFromParent()
                    }
                }
            }
            
        }
        
        for i in 0..<respuestas.count {
            
            if nodeNames.contains(respuestas[i]) && nodeNames.contains(kShipFiredBulletName) {
                // Ship bullet hit an invader
                // adjustInvaderHealth(by: -0.334, nombreInvader: respuestasHealt[i])
                
                respuestasHealt[i] = respuestasHealt[i] - 0.334
                
                print("respuestasHealt[i]: \(respuestasHealt[i])")
                
                if respuestasHealt[i] <= 0.0 {
                    destruyeNave = true
                    
                    //run(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
                    contact.bodyA.node!.removeFromParent()
                    contact.bodyB.node!.removeFromParent()
                    
                    var respDestruida:String = ""
                    
                    if(respuestas[i].contains("brainruno.png")){
                        respDestruida = "Uno"
                    }
                    if(respuestas[i].contains("braindos.png")){
                        respDestruida = "Dos"
                    }
                    if(respuestas[i].contains("brainrtres.png")){
                        respDestruida = "Tres"
                    }
                    if(respuestas[i].contains("brainrcuatro.png")){
                        respDestruida = "Cuatro"
                    }
                    
                    print("respDestruida: \(respDestruida)")
                    print("numRespCorrecta: \(numRespCorrecta!)")
                    
                    if (numRespCorrecta!.contains(respDestruida)){
                        let correctaSi = "Si"
                        self.viewController.siguientePreguntaNext(respuestaUser: correctaSi)
                        //mensaje de exito
                    }else{
                        let correctaNo = "No"
                        self.viewController.siguientePreguntaNext(respuestaUser: correctaNo)
                        //mesnaje de error y explota la nave
                        
                    }
                    
                    /*  if(respuestas[i].contains(".PNG")){
                     correcta = correcta + ".PNG"
                     }
                     if(respuestas[i].contains(".png")){
                     correcta = correcta + ".png"
                     }*/
                    
                    print("correcta__: \(correcta)")
                    print("respuestas[i]__: \(respuestas[i])")
                    
                    //if (respuestas[i]==correcta){
                    /*   if (respuestas[i]==correcta){
                     
                     self.viewController.siguientePreguntaNext(respuestaUser: respuestas[i])
                     
                     //mensaje de exito
                     }else{
                     self.viewController.siguientePreguntaNext(respuestaUser: respuestas[i])
                     //mesnaje de error y explota la nave
                     
                     }*/
                } else {
                    // 3
                    if let invader = childNode(withName: respuestas[i]) {
                        invader.alpha = CGFloat(respuestasHealt[i])
                        if contact.bodyA.node == invader {
                            contact.bodyB.node!.removeFromParent()
                        } else {
                            contact.bodyA.node!.removeFromParent()
                        }
                    }
                }
                
                
                /*      run(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
                 //removed the bullet
                 contact.bodyA.node!.removeFromParent()
                 //removed the invader
                 contact.bodyB.node!.removeFromParent()*/
                
                // 4
                adjustScore(by: 100)
            }
        }
        
    }
    
    // Game End Helpers
    
    func isGameOver() -> Bool {
        // 1
        var invader = childNode(withName: InvaderType.name)
        var invaderTooLow = false
        for i in 0..<respuestas.count {
            invader = childNode(withName: respuestas[i])
            
            enumerateChildNodes(withName: respuestas[i]) { node, stop in
                
                if (Float(node.frame.minY) <= self.kMinInvaderBottomHeight || self.destruyeNave == true)   {
                    invaderTooLow = true
                    stop.pointee = true
                }
            }
        }
        
        // 3
        let ship = childNode(withName: kShipName)
        
        // 4
        return invader == nil || invaderTooLow || ship == nil
    }
    
    func endGame() {
        // 1
        if !gameEnding {
            
            gameEnding = true
            
            // 2
            motionManager.stopAccelerometerUpdates()
            
            if shipHealth <= 0.0 {
                // 2
                self.viewController.siguientePreguntaNext(respuestaUser: "")
            }
            
            // 3
            /*  let gameOverScene: GameOverScene = GameOverScene(size: size)
             
             view?.presentScene(gameOverScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 1.0))*/
        }
    }
    
}
