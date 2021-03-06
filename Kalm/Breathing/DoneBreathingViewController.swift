//
//  DoneBreathingViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 06/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit

class DoneBreathingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var orangeCircle: UIImageView!
    @IBOutlet weak var backToMainMenuOutlet: UIButton!
    
    @IBOutlet weak var backtoMainMenuButton: UIButton!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    // MARK: - Variables
    var time = 0
    var minutes = 0
    var seconds = 0
    
    var timeStart : Date?
    var timeEnd : Date?
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        //take a note time End
        orangeCircle.accessibilityIgnoresInvertColors = true
        backToMainMenuOutlet.accessibilityIgnoresInvertColors = true
        timeEnd = Date()
        saveSession()
        
        //update Label in Storyboard
        if time > 59 {
            minutes = time / 60
            seconds = time - (60 * minutes)
        } else {
            minutes = 0
            seconds = time
        }
        
        if minutes < 10 {
            if seconds < 10 {
                timerLabel.text = "0\(minutes) : 0\(seconds)"
            } else {
                timerLabel.text = "0\(minutes) : \(seconds)"
            }
        } else {
            if seconds < 10 {
                timerLabel.text = "\(minutes) : 0\(seconds)"
            } else {
                timerLabel.text = "\(minutes) : \(seconds)"
            }
        }
        
        doneLabel.accessibilityLabel = "Your session is done"
        
        if minutes != 0{
            durationLabel.accessibilityLabel = "Your session has finished in \(minutes) minutes \(seconds) seconds"
            timerLabel.accessibilityLabel = "Your session has finished in \(minutes) minutes \(seconds) seconds"
        }else{
             durationLabel.accessibilityLabel = "Your session has finished in \(seconds) seconds"
            timerLabel.accessibilityLabel = "Your session has finished in \(seconds) seconds"
        }
        
        backtoMainMenuButton.accessibilityLabel = "Tap to back to main menu"
        backtoMainMenuButton.accessibilityTraits = UIAccessibilityTraitButton
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func saveSession(){
        if let startDate = timeStart, let endDate = timeEnd{
            let session = Session(startDate: startDate, endDate: endDate)
            CloudKitHelper().createNewSession(session: session)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Button Delegate
    @IBAction func backToMainMenuButtonPressed() {
        
        performSegue(withIdentifier: "doneBreathingToHome", sender: self)
    }
}
