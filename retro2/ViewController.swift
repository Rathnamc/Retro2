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

    @IBOutlet weak var outputLbl: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    
    var screenValue = ""
    var leftValueString = ""
    var rightValueString = ""
    
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
        audioPlayer.play()
    }

}

