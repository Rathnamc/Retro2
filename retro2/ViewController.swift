//
//  ViewController.swift
//  retro2
//
//  Created by Christopher Rathnam on 11/28/15.
//  Copyright © 2015 Christopher Rathnam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    var screenValue = ""
    var leftValueString = ""
    var rightValueString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Store numbers into strings
    
        
        //Locates the sound file. Set as constant
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        //Error catch if audio does not play
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundURL)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    //Function Controls actions when number pad is pressed
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        //Grab tag and store into running number
        screenValue += "\(btn.tag)"
        //display the button on the screen
        outputLbl.text = screenValue
    }
    
    @IBAction func equalPressed(sender: AnyObject) {
        processOperator(currentOperation)
    }
    
    @IBAction func addPressed(sender: AnyObject) {
        processOperator(Operation.Add)
    }
    
    @IBAction func subtractPressed(sender: AnyObject) {
        processOperator(Operation.Subtract)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject) {
        processOperator(Operation.Multiply)
    }
    
    @IBAction func dividePressed(sender: AnyObject){
        processOperator(Operation.Divide)
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        resetValues(Operation.Empty)
    }
    
    func resetValues(opValue: Operation){
        
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = result
        
    }
    
    func processOperator(opValue: Operation) {
        playSound()
        //Check is left value is already been entered.
        if currentOperation != Operation.Empty {
            rightValueString = screenValue
            screenValue = ""
            
            if currentOperation == Operation.Add {
                result = "\(Double(leftValueString)! + Double(rightValueString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValueString)! - Double(rightValueString)!)"
            } else if currentOperation == Operation.Multiply {
                result = "\(Double(leftValueString)! * Double(rightValueString)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValueString)! / Double(rightValueString)!)"
            }
            
            leftValueString = result
            outputLbl.text = result
            // uses stored operator on next value entered
            currentOperation = opValue
            
        } else {
            
            //take snap shot of left value
            leftValueString = screenValue
            //clear the current value from screen
            screenValue = ""
            //store the current operator
            currentOperation = opValue
            
        }
    }
    
    func playSound() {
        if audioPlayer.playing{
            audioPlayer.stop()
        }
        audioPlayer.play()
    }
  
}

