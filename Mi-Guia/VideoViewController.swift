//
//  VideoViewController.swift
//  Mi-Guia
//
//  Created by Mariano Rodriguez Abarca on 27/05/20.
//  Copyright © 2020 Mariano Rodriguez Abarca. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {
    
    var parametroCuestionario:String = ""
    
    
    @IBOutlet weak var vistaVideo: UIView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
         
         
              UINavigationBar.appearance().barTintColor = UIColor(red:0.16, green:0.55, blue:0.79, alpha:1.0)
              UINavigationBar.appearance().tintColor = UIColor.white
              UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)]
          
          print("parametroCuestionario \(parametroCuestionario)")
          
          videoPlay()

          // Do any additional setup after loading the view.
     }
      
     func videoPlay()
       {
          let URLfija = "https://www.pypsolucionesintegrales.com/clases_comipems_premier_pro/"
          let URLvideo = URLfija + parametroCuestionario
          
          let videoURL = URL(string: URLvideo)
          
          let player = AVPlayer(url: videoURL!)
          let playerViewController = AVPlayerViewController()
          playerViewController.player = player

          self.addChildViewController(playerViewController)
          self.view.addSubview(playerViewController.view)
          playerViewController.view.frame = self.vistaVideo.frame

          player.play()

       }

      /*
      // MARK: - Navigation

      // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
      }
      */
      
      
      func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController){
            print("playerViewControllerWillStartPictureInPicture")
        }

        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController)
        {
            print("playerViewControllerDidStartPictureInPicture")

        }
        func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error)
        {
            print("failedToStartPictureInPictureWithError")
        }
        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController)
        {
            print("playerViewControllerWillStopPictureInPicture")
        }
        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController)
        {
            print("playerViewControllerDidStopPictureInPicture")
        }
        func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool
        {
            print("playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart")
            return true
        }
      

}
