//
//  BreathingViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 06/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit

class BreathingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var innerCircle: UIImageView!
    
    // MARK: - Variables
    var inhaleDuration: Int = 0
    var exhaleDuration: Int = 0
    var minutes = 0
    var seconds = 0
    var time = 0
    var timer = Timer()
    var timer2 = Timer()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        
        // Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BreathingViewController.updateTimer), userInfo: nil, repeats: true)
        
        view.addSubview(circle)
        
        innerCircle.layer.zPosition = .greatestFiniteMagnitude
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        grow()
    }
    
    // MARK: - Grow and Shrink Functions
    @objc func grow(){
        innerCircle.image = UIImage(named: "InhaleRound")
        let scaleAnimation = constructScaleAnimation(startingScale: 1.0, endingScale: 1.5, animationDuration: inhaleDuration)
        circle.layer.add(scaleAnimation, forKey: "scale")
        timer2 = Timer.scheduledTimer(timeInterval: Double(inhaleDuration), target: self, selector: #selector(BreathingViewController.shrink), userInfo: nil, repeats: false)
    }
    
    @objc func shrink() {
        innerCircle.image = UIImage(named: "ExhaleRound")
        let scaleAnimation = constructSmallScaleAnimation(startingScale: 1.5, endingScale: 1.0, animationDuration: exhaleDuration)
        circle.layer.add(scaleAnimation, forKey: "scale")
        timer2 = Timer.scheduledTimer(timeInterval: Double(exhaleDuration), target: self, selector: #selector(BreathingViewController.grow), userInfo: nil, repeats: false)
        
    }
    
    private func constructScaleAnimation(startingScale: CGFloat, endingScale: CGFloat, animationDuration: Int) -> CABasicAnimation{
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = startingScale
        scaleAnimation.toValue = endingScale
        scaleAnimation.duration = CFTimeInterval(animationDuration)
        
        scaleAnimation.autoreverses = false
        
        return scaleAnimation
    }
    
    private func constructSmallScaleAnimation (startingScale: CGFloat, endingScale: CGFloat, animationDuration: Int) -> CABasicAnimation{
        let smallScaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallScaleAnimation.fromValue = startingScale
        smallScaleAnimation.toValue = endingScale
        smallScaleAnimation.duration = CFTimeInterval(animationDuration)
        
        smallScaleAnimation.autoreverses = false
        
        return smallScaleAnimation
    }
    
    // MARK: - Timer
    @objc func updateTimer(){
        time += 1
        
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
    }
    
    // MARK: - Button Delegate
    @IBAction func stopButtonPressed() {
        performSegue(withIdentifier: "breathingToDoneBreathing", sender: self)
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DoneBreathingViewController{
            destination.time = time
        }
    }
}
