//
//  ShowSplashScreenViewController.swift
//  Kalm
//
//  Created by Ferlix Yanto Wang on 07/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit

class ShowSplashScreenViewController: UIViewController {

    // MARK: - App Life Cycle
    override func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.showNavigationController()
        })
        super.viewDidLoad()
    }
    
    func showNavigationController(){
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }
}
