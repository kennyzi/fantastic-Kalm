//
//  BreathingViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 06/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit
import AVFoundation
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
    var player: AVAudioPlayer?
    var timeStart : Date?
    
    var inhaleSFx = AVAudioPlayer()
    var exhaleSFx = AVAudioPlayer()
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        timeStart = Date()
        stopButton.accessibilityIgnoresInvertColors = true
        circle.accessibilityIgnoresInvertColors = true
        innerCircle.accessibilityIgnoresInvertColors = true
        // Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BreathingViewController.updateTimer), userInfo: nil, repeats: true)
        
        let timerVoiceOver = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(voiceOverTalk), userInfo: nil, repeats: true)
        
//        view.addSubview(circle)
        
        stopButton.accessibilityLabel = "Stop Button. Tap to stop"
        stopButton.accessibilityTraits = UIAccessibilityTraitButton
        
        timerLabelAccessibility()
        setAudioExhale()
        setAudioInhale()
        
        innerCircle.layer.zPosition = .greatestFiniteMagnitude
        self.navigationController?.isNavigationBarHidden = true
        
        playBackGroundMusic()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        grow()
    }
    
    func timerLabelAccessibility(){
        if minutes != 0{
             timerLabel.accessibilityLabel = "Your session has been started for \(minutes) minutes \(seconds) seconds"
        }else{
             timerLabel.accessibilityLabel = "Your session has been started for \(seconds) seconds"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        timer2.invalidate()
        timer.invalidate()
    }
    
    // MARK: - Grow and Shrink Functions
    @objc func grow(){
        innerCircle.image = UIImage(named: "InhaleRound")
        let scaleAnimation = constructScaleAnimation(startingScale: 1.0, endingScale: 1.5, animationDuration: inhaleDuration)
        circle.layer.add(scaleAnimation, forKey: "scale")
        inhaleSFx.play()
        timer2 = Timer.scheduledTimer(timeInterval: Double(inhaleDuration), target: self, selector: #selector(BreathingViewController.shrink), userInfo: nil, repeats: false)
    }
    
    @objc func shrink() {
        innerCircle.image = UIImage(named: "ExhaleRound")
        let scaleAnimation = constructSmallScaleAnimation(startingScale: 1.5, endingScale: 1.0, animationDuration: exhaleDuration)
        circle.layer.add(scaleAnimation, forKey: "scale")
        exhaleSFx.play()
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
        
        timerLabelAccessibility()
    }
    
    // MARK: - Button Delegate
    @IBAction func stopButtonPressed() {
        performSegue(withIdentifier: "breathingToDoneBreathing", sender: self)
        do {
            player?.stop()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DoneBreathingViewController{
            destination.time = time
            destination.timeStart = timeStart
        }
    }
    func playBackGroundMusic(){
        guard let url = Bundle.main.url(forResource: "AmbientSound", withExtension: "m4a") else {return}
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {return}
            
            player.play()
            player.numberOfLoops = -1
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func setAudioInhale(){
        let musicFile = Bundle.main.path(forResource: "inhale", ofType: ".mp3")
        
        do{
            try inhaleSFx = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile!))
        }catch {
            print("audio error")
        }
    }
    
    func setAudioExhale(){
        let musicFile = Bundle.main.path(forResource: "exhale", ofType: ".mp3")
        
        do{
            try exhaleSFx = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile!))
        }catch {
            print("audio error")
        }
    }
    
    @objc func voiceOverTalk(){
        UIAccessibility.isVoiceOverRunning
    }
}
