//
//  ViewController.swift
//  retrocalculator
//
//  Created by Rowan Rhodes on 11/02/2016.
//  Copyright © 2016 Rowan Rhodes. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    enum Operation: String {
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "Empty"
    }

    @IBOutlet weak var outputlabel: UILabel!
    
    var btnsound: AVAudioPlayer!
    var runningnumber = ""
    var leftvalstr = ""
    var rightvalst = ""
    var CurrentOperation: Operation = Operation.empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
    let soundurl = NSURL(fileURLWithPath: path!)
        
        do {
            
            try btnsound = AVAudioPlayer(contentsOfURL: soundurl)

            btnsound.prepareToPlay()
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }

    @IBAction func numberpressed(btn: UIButton!) {
        
        playsound()
        
        runningnumber += "\(btn.tag)"
        outputlabel.text = runningnumber
        
    }
    
    @IBAction func ondividepressed(sender: AnyObject) {
        processoperation(Operation.divide)
    }
    
    @IBAction func onmultiplypressed(sender: AnyObject) {
        processoperation(Operation.multiply)
    }
    
    @IBAction func onsubtractpressed(sender: AnyObject) {
        processoperation(Operation.subtract)
    }
    
    @IBAction func onadditionpressed(sender: AnyObject) {
        processoperation(Operation.add)
    }
    
    @IBAction func onequalspressed(sender: AnyObject) {
        processoperation(CurrentOperation)
    }
    
    func processoperation(op: Operation) {
        playsound()
        
        if CurrentOperation != Operation.empty {
            
            if runningnumber != "" {
            rightvalst = runningnumber
            runningnumber = ""
            
            if CurrentOperation == Operation.multiply {
                result = "\(Double(leftvalstr)! * (Double(rightvalst)!))"
            }
            
            else if CurrentOperation == Operation.divide {
                result = "\(Double(leftvalstr)! / (Double(rightvalst)!))"
            }
            
            else if CurrentOperation == Operation.subtract {
                result = "\(Double(leftvalstr)! - (Double(rightvalst)!))"
            }
            
            else if CurrentOperation == Operation.add {
                result = "\(Double(leftvalstr)! + (Double(rightvalst)!))"
            }
            
            leftvalstr = result
            outputlabel.text = result
                
            }
            
            CurrentOperation = op
            
        } else {
            
            //this is the first time an operator has been pressed
            leftvalstr = runningnumber
            runningnumber = ""
            CurrentOperation = op
        }
    }
    
    func playsound() {
        if btnsound.playing {
            btnsound.stop()
        }
        
        btnsound.play()
    }
}

