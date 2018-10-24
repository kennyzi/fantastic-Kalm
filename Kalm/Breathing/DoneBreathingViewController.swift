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
    
    
    // MARK: - Variables
    var time = 0
    var minutes = 0
    var seconds = 0
    
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        
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
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Button Delegate
    @IBAction func backToMainMenuButtonPressed() {
        performSegue(withIdentifier: "doneBreathingToHome", sender: self)
    }
    
}
