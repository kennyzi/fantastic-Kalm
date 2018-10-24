//
//  InterfaceController.swift
//  KalmWatch Extension
//
//  Created by Kennyzi Yusuf on 25/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // MARK: - Outlets
    @IBOutlet var labelTimer: WKInterfaceLabel!
    @IBOutlet var buttonStart: WKInterfaceButton!
    
    // MARK: - Variables
    var timer = Timer()
    var time = 0
    var minutes = 0
    var seconds = 0
    var stop: Bool = false
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
    }
    
    @IBAction func Start() {
        
        if stop == false{
            buttonStart.setBackgroundImageNamed("StopBtn256")
            labelTimer.setText("00 : 00")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(InterfaceController.updateTimer), userInfo: nil, repeats: true)
            stop = true
        }else{
            presentController(withName: "breathing", context: self)
            timer.invalidate()
            buttonStart.setBackgroundImageNamed("Start256")
            labelTimer.setText("Breath using your stomach")
            stop = false
            time = 0
            
        }
    }
    
    @objc func updateTimer(){
        
        time += 1
        var temp : String
        if time > 59 {
            minutes = time / 60
            seconds = time - (60 * minutes)
        } else {
            minutes = 0
            seconds = time
        }
        
        if minutes < 10 {
            if seconds < 10 {
                temp = "0\(minutes) : 0\(seconds)"
                labelTimer.setText(temp)
            } else {
                temp = "0\(minutes) : \(seconds)"
                labelTimer.setText(temp)
            }
        } else {
            if seconds < 10 {
                temp = "\(minutes) : 0\(seconds)"
                labelTimer.setText(temp)
            } else {
                temp = "\(minutes) : \(seconds)"
                labelTimer.setText(temp)
            }
        }
    }
}
