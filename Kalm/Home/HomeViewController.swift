//
//  HomeViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 06/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit
import Intents
class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    // MARK: - Outlets
    @IBOutlet weak var leftChangeDurationButton: UIButton!
    @IBOutlet weak var rightChangeDurationButton: UIButton!
    @IBOutlet weak var inhaleDurationLabel: UILabel!
    @IBOutlet weak var exhaleDurationLabel: UILabel!
    
    @IBOutlet weak var navigationItemTop: UINavigationItem!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var leftBarButtonView: UIView!
    @IBOutlet weak var rightBarButtonView: UIView!
    @IBOutlet weak var changeDurationPickerView: UIPickerView!
    
    @IBOutlet weak var blurView: UIView!
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var readyShapeOutlet: UIImageView!
    @IBOutlet weak var explanationOutlet: UILabel!
    
    
    // MARK: - Variables
    var inhaleDuration = 3
    var exhaleDuration = 5
    var duration = ["3 sec", "4 sec", "5 sec", "6 sec", "7 sec", "8 sec"]
    let screenSize = UIScreen.main.bounds
    
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
        //Get inhaleDuration & exhaleDuration
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "inhaleDuration") != nil{
            if let savedInhaleDuration = UserDefaults.standard.value(forKey: "inhaleDuration") as? Int{
                inhaleDuration = savedInhaleDuration
            }
        }
        
        if UserDefaults.standard.value(forKey: "exhaleDuration") != nil{
            if let savedExhaleDuration = UserDefaults.standard.value(forKey: "exhaleDuration") as? Int{
                exhaleDuration = savedExhaleDuration
            }
        }
        
        
        
        //dynamic text
        explanationOutlet.font = UIFont.preferredFont(forTextStyle: .body)
        explanationOutlet.adjustsFontForContentSizeCategory = true
        //IGNORE LIST
        startButton.accessibilityIgnoresInvertColors = true
        readyShapeOutlet.accessibilityIgnoresInvertColors = true
        
        //AccesibilityTrait
        readyShapeOutlet.accessibilityLabel = "Breathe indicator, Ready"
        readyShapeOutlet.accessibilityTraits = UIAccessibilityTraitImage
        
        startButton.accessibilityLabel = "Start button. Press to start Session"
        startButton.accessibilityTraits = UIAccessibilityTraitButton
        
        leftChangeDurationButton.accessibilityLabel = "\(inhaleDuration) seconds inhale. Tap to change"
        leftChangeDurationButton.accessibilityTraits = UIAccessibilityTraitButton
        
        rightChangeDurationButton.accessibilityLabel = "\(exhaleDuration) seconds exhale. Tap to change"
        rightChangeDurationButton.accessibilityTraits = UIAccessibilityTraitButton

        
        changeDurationPickerView.delegate = self
        changeDurationPickerView.dataSource = self
        
        // Initial setup for the custom picker view area (rounded shapes)
        bottomView.layer.cornerRadius = 13
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = UIColor.clear.cgColor
        
        toolbar.layer.cornerRadius = 10
        toolbar.layer.borderWidth = 1
        toolbar.layer.borderColor = UIColor.clear.cgColor
        
        leftBarButtonView.layer.borderWidth = 1
        leftBarButtonView.layer.cornerRadius = 15
        leftBarButtonView.layer.borderColor = UIColor.clear.cgColor
        
        rightBarButtonView.layer.borderWidth = 1
        rightBarButtonView.layer.cornerRadius = 15
        rightBarButtonView.layer.borderColor = UIColor.clear.cgColor
        
        // Adding a single line under the toolbar pickerview
        let path = UIBezierPath()
        path.move(to: CGPoint(x: toolbar.bounds.minX, y: 44.0 ))
        path.addLine(to: CGPoint(x: toolbar.bounds.maxX, y: 44.0 ))
        path.close()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor(red: 216/255, green: 141/255, blue: 103/255, alpha: 1).cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 1.5
        shape.lineCap = kCALineCapRound
        
        toolbar.layer.addSublayer(shape)
        
        // Setting up the blur view effect
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurView.bounds
        blurView.backgroundColor = UIColor.clear
        blurView.addSubview(blurEffectView)
        
        // Setting up custom navigation bar
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "InfoBtn"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn1.addTarget(self, action: #selector(HomeViewController.infoButtonPressed), for: .touchUpInside)
        btn1.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        btn1.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        let item1 = UIBarButtonItem(customView: btn1)
        item1.accessibilityLabel = "Info"
        item1.accessibilityTraits = UIAccessibilityTraitButton
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "GraphBtn"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn2.addTarget(self, action: #selector(HomeViewController.graphButtonPressed), for: .touchUpInside)
        btn2.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        btn2.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        let item2 = UIBarButtonItem(customView: btn2)
        item2.accessibilityLabel = "History"
        item2.accessibilityTraits = UIAccessibilityTraitButton
        
        navigationItemTop.setLeftBarButtonItems([item1], animated: true)
        navigationItemTop.setRightBarButtonItems([item2], animated: true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        inhaleDurationLabel.text = String(inhaleDuration) + " sec"
        exhaleDurationLabel.text = String(exhaleDuration) + " sec"
        
        //Request Siri Authorization
        donateIntent()
        INPreferences.requestSiriAuthorization { (status) in
            print(status)
        }
//        INVocabulary.shared().setVocabularyStrings(["Breath","Start Session"], of: .workoutActivityName)
        
        
    }
    
    func donateIntent(){
        print("Start donate")
        
        let intent = StartBreathingSessionIntent()
        
        print("Set intent")
        
        intent.suggestedInvocationPhrase = "Start session with Calm"
//        intent.inhale = NSNumber(integerLiteral: inhaleDuration)
//        intent.exhale = NSNumber(integerLiteral: exhaleDuration)
        
        intent.inhale = "A"
        intent.exhale = "B"
        
        print("Set interaction")
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        print("mencoba donate")
        
        interaction.donate { (error) in
            if error != nil{
                if let error = error as NSError?{
                    print("Interaction Donation failed : \(error)")
                }else{
                    print("Success donated interaction")
                }
            }else{
                print(error)
                print("gak ada error dul")
            }
        }
    }
    
    
    // MARK: - Button Delegate
    @IBAction func startButtonPressed() {
        
        UserDefaults.standard.setValue(inhaleDuration, forKey: "inhaleDuration")
        UserDefaults.standard.setValue(exhaleDuration, forKey: "exhaleDuration")
        
        performSegue(withIdentifier: "homeToBreathing", sender: self)
    }
    
    @objc func infoButtonPressed() {
        performSegue(withIdentifier: "homeToInfo", sender: self)
    }
    
    @objc func graphButtonPressed() {
        performSegue(withIdentifier: "homeToHistory", sender: self)
//        performSegue(withIdentifier: "homeToGraph", sender: self)
    }
    
    @IBAction func leftChangeDurationButtonPressed() {
        
        // Animate the bottom view
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: ((self.screenSize.height)/3)*2, width: self.screenSize.width, height: ((self.screenSize.height)/3)*2)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: self.screenSize.width, height: 44.0)
        })
        
        // Activate blur effect
        blurView.alpha = 1.0
        changeDurationPickerView.selectRow(inhaleDuration-3, inComponent: 0, animated: false)
        changeDurationPickerView.selectRow(exhaleDuration-3, inComponent: 1, animated: false)
        
        
        changeDurationPickerView.accessibilityLabel = "Inhale"
    }
    
    
    
    @IBAction func rightChangeDurationButtonPressed() {
        // Animate the bottom view
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: ((self.screenSize.height)/3)*2, width: self.screenSize.width, height: ((self.screenSize.height)/3)*2)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: self.screenSize.width, height: 44.0)
        })
        
        // Activate blur effect
        blurView.alpha = 1.0
        changeDurationPickerView.selectRow(inhaleDuration-3, inComponent: 0, animated: false)
        changeDurationPickerView.selectRow(exhaleDuration-3, inComponent: 1, animated: false)
        changeDurationPickerView.accessibilityLabel = "\(exhaleDuration) Exhale"
    }
    
    
    
    // MARK: - Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duration[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = duration[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Roboto", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        return myTitle
    }
    
    
    // MARK: - Button Delegate for Picker View
    @IBAction func cancelButtonPressed() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: self.screenSize.height, width: self.screenSize.width, height: 0)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: self.screenSize.width, height: 0)
        }, completion: nil)
        
        blurView.alpha = 0.0
    }
    
    @IBAction func doneButtonPressed() {
        var selectedIndex = changeDurationPickerView.selectedRow(inComponent: 0)
        var data = duration[selectedIndex]
        
        // To get the first element of the string
        let start = String.Index(encodedOffset: 0)
        let end = String.Index(encodedOffset: 1)
        var newDuration = String(data[start..<end])
        inhaleDuration = Int(newDuration)!
        
        selectedIndex = changeDurationPickerView.selectedRow(inComponent: 1)
        data = duration[selectedIndex]
        newDuration = String(data[start..<end])
        exhaleDuration = Int(newDuration)!
        
        inhaleDurationLabel.text = "\(inhaleDuration) sec"
        exhaleDurationLabel.text = "\(exhaleDuration) sec"
        
        rightChangeDurationButton.accessibilityLabel = "\(exhaleDuration) seconds exhale. Tap to change"
        leftChangeDurationButton.accessibilityLabel = "\(inhaleDuration) seconds inhale. Tap to change"
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: self.screenSize.height, width: self.screenSize.width, height: 0)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: self.screenSize.width, height: 0)
        }, completion: nil)
        
        blurView.alpha = 0.0
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BreathingViewController {
//            destination.inhaleDuration = inhaleDuration
//            destination.exhaleDuration = exhaleDuration
        }
    }
}

extension HomeViewController : UIPickerViewAccessibilityDelegate{
    func pickerView(_ pickerView: UIPickerView, accessibilityLabelForComponent component: Int) -> String? {
        if component == 0 {
            return "inhale"
        }
        else
        {
            return "exhale"
        }
    }
}
