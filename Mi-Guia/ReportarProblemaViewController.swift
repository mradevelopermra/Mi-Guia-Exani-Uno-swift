//
//  ReportarProblemaViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 2/6/19.
//  Copyright © 2019 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit
import Alamofire

class ReportarProblemaViewController: UIViewController {

    
    @IBOutlet weak var mail: UITextField!
    
    @IBOutlet weak var problema: UITextField!
    
    var mailUser = ""
    var problemaReporte = ""
    
    var preguntasRealizadas:String?
    
    
    @IBAction func reportar(_ sender: Any) {
        
        mailUser = mail.text!
        problemaReporte = problema.text!
        
        if(!mailUser.isEmpty){
            
            if(!problemaReporte.isEmpty){
                
                insertaProblema()
                
                mail.text = ""
                problema.text = ""
                
                
                // create the alert
                let alert = UIAlertController(title: "Atención", message: "¡Su reporte fue recibidó!", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                
            }else{
                
                // create the alert
                let alert = UIAlertController(title: "Atención", message: "¡Favor de agregar un problema!", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        }else{
            
            // create the alert
            let alert = UIAlertController(title: "Atención", message: "¡Favor de agregar una cuenta de e-mail!", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            //     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    

    @IBOutlet weak var btnReportLey: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnReportLey.backgroundColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
        

        // Do any additional setup after loading the view.
    }
    
    func insertaProblema(){
        
        let urlString = "http://www.pypsolucionesintegrales.com/ventas/reporta_problema_comipems.php"
        
        mailUser = mail.text! + " iOS-Exani Uno-pro"
        problemaReporte = problema.text!
        
        let parameters1: Parameters=[
            "mail":mailUser,
            "reporte":problemaReporte
        ]
        
        print("parametersDeudas \(parameters1)")
        
        
        
        Alamofire.request(urlString, method: .post, parameters: parameters1).responseJSON { responseJSON in
                    print("responseJSON \(responseJSON)")
            print(responseJSON)
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
