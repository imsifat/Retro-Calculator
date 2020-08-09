//
//  ViewController.swift
//  RetroCalc
//
//  Created by Imran Sifat on 17/6/20.
//  Copyright © 2020 Imran Sifat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   //IBOutlet
    
     @IBOutlet weak var outPutLBL: UILabel!
     
     //Variables
     var numberOnScreen:Double = 0;
     var previousNumber:Double = 0;
     var performingMath = false
     var operation = 0;
    var btnSound:AVAudioPlayer!

     
     override func viewDidLoad() {
         super.viewDidLoad()
         let path = Bundle.main.path(forResource: "btn", ofType: "wav")
         let soundURL = URL(fileURLWithPath: path!)
         
         do{
             try btnSound = AVAudioPlayer(contentsOf: soundURL)
             btnSound.prepareToPlay()
         } catch let err as NSError{
             print(err.debugDescription)
         }
    }

     @IBAction func numberBTN(_ sender: UIButton) {
        soundPlay()
         if performingMath == true
         {
            outPutLBL.text = ""
            outPutLBL.text = String(sender.tag)
            numberOnScreen = Double(outPutLBL.text!)!
            performingMath = false
         }
         else
         {
             outPutLBL.text = outPutLBL.text! + String(sender.tag)
             numberOnScreen = Double(outPutLBL.text!)!
         }
     }
     @IBAction func operators(_ sender: UIButton) {
        soundPlay()
         if outPutLBL.text != "" && sender.tag != 11 && sender.tag != 10
         {
             previousNumber = Double(outPutLBL.text!)!
             
             if sender.tag == 12 //Divide
             {
                 outPutLBL.text = "/";
             }
             else if sender.tag == 13 //Multiply
             {
                 outPutLBL.text = "x";
             }
             else if sender.tag == 14 //Minus
             {
                 outPutLBL.text = "-";
             }
             else if sender.tag == 15 //Plus
             {
                 outPutLBL.text = "+";
             }
             
             operation = sender.tag
             performingMath = true;
         }
         else if sender.tag == 10
         {
             if operation == 12
             {
                 outPutLBL.text = String(previousNumber / numberOnScreen)
             }
             else if operation == 13
             {
                 outPutLBL.text = String(previousNumber * numberOnScreen)
             }
             else if operation == 14
             {
                 outPutLBL.text = String(previousNumber - numberOnScreen)
             }
             else if operation == 15
             {
                 outPutLBL.text = String(previousNumber + numberOnScreen)
             }
            
         }else if sender.tag == 11{
             if outPutLBL.text != "" {
                outPutLBL.text?.removeAll()
             }
         }
     }
    func soundPlay(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
}


