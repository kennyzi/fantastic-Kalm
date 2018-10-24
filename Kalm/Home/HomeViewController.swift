//
//  HomeViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 06/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit

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
    
    
    // MARK: - Variables
    var inhaleDuration = 5
    var exhaleDuration = 5
    var duration = ["3 sec", "4 sec", "5 sec", "6 sec", "7 sec", "8 sec"]
    
    
    // MARK: - App Life Cycle
    override func viewDidLoad() {
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
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "GraphBtn"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn2.addTarget(self, action: #selector(HomeViewController.graphButtonPressed), for: .touchUpInside)
        btn2.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        btn2.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        let item2 = UIBarButtonItem(customView: btn2)
        
        navigationItemTop.setLeftBarButtonItems([item1], animated: true)
        navigationItemTop.setRightBarButtonItems([item2], animated: true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        inhaleDurationLabel.text = String(inhaleDuration) + " sec"
        exhaleDurationLabel.text = String(exhaleDuration) + " sec"
        
        super.viewDidLoad()
    }
    
    
    // MARK: - Button Delegate
    @IBAction func startButtonPressed() {
        performSegue(withIdentifier: "homeToBreathing", sender: self)
    }
    
    @objc func infoButtonPressed() {
        performSegue(withIdentifier: "homeToInfo", sender: self)
    }
    
    @objc func graphButtonPressed() {
        performSegue(withIdentifier: "homeToGraph", sender: self)
    }
    
    @IBAction func leftChangeDurationButtonPressed() {
        // Animate the bottom view
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: 548.0, width: 375.0, height: 265.0)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: 375.0, height: 44.0)
        })
        
        // Activate blur effect
        blurView.alpha = 1.0
        changeDurationPickerView.selectRow(inhaleDuration-3, inComponent: 0, animated: false)
        changeDurationPickerView.selectRow(exhaleDuration-3, inComponent: 1, animated: false)
    }
    
    @IBAction func rightChangeDurationButtonPressed() {
        // Animate the bottom view
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: 548.0, width: 375.0, height: 265.0)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: 375.0, height: 44.0)
        })
        
        // Activate blur effect
        blurView.alpha = 1.0
        changeDurationPickerView.selectRow(inhaleDuration-3, inComponent: 0, animated: false)
        changeDurationPickerView.selectRow(exhaleDuration-3, inComponent: 1, animated: false)
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
            self.bottomView.frame = CGRect(x: 0.0, y: 812.0, width: 375.0, height: 0)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: 375.0, height: 0)
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
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.bottomView.frame = CGRect(x: 0.0, y: 812.0, width: 375.0, height: 0)
            self.toolbar.frame = CGRect(x: 0.0, y: (self.view.superview?.frame.origin.y)!, width: 375.0, height: 0)
        }, completion: nil)
        
        blurView.alpha = 0.0
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BreathingViewController {
            destination.inhaleDuration = inhaleDuration
            destination.exhaleDuration = exhaleDuration
        }
    }
}
