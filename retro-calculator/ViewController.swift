//
//  ViewController.swift
//  retro-calculator
//
//  Created by Zachary West Guo on 7/31/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    //outlets
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    var leftValStr: String = ""
    var rightValStr: String = ""
    var currentOperation:Operation = Operation.Empty
    var result:String = ""
    
    //actions
    @IBAction func clear(sender: AnyObject) {
        playSound()
        outputLbl.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
    }
    
    @IBAction func numberPressed(btn:UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)!*Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)!/Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)!-Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)!+Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else{
            //first time operator is pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let error as NSError{
            print(error.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

