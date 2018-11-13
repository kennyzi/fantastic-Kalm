//
//  AppDelegate.swift
//  Kalm
//
//  Created by Marvin Randy on 04/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import UIKit
import Intents
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Check first time launched
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        if !launchedBefore {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "swipingVC") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else {
            sleep(1)
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "mainVC") as UIViewController
            let navigationController = UINavigationController(rootViewController: initialViewController)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let intent = userActivity.interaction?.intent as? INStartWorkoutIntent else {
            print("AppDelegate: Start Workout Intent - FALSE")
            return false
        }
        print("AppDelegate: Start Workout Intent - TRUE")
        print(intent)
        guard let name = intent.workoutName?.spokenPhrase else {return false}
        
        if name == "Start Session"{
            print("namanya bener")
            var navigationController2 = window?.rootViewController as? UINavigationController
            var workoutVC2 = navigationController2?.viewControllers
            
            print(navigationController2)
            print(workoutVC2)
//            guard let navigationController = window?.rootViewController as? UINavigationController,
//                let workoutVC = navigationController.viewControllers.last as? BreathingViewController else{
//                    print("salaahhh")
//                    return false
//            }
//            workoutVC2?.append(BreathingViewController())
//            navigationController2?.performSegue(withIdentifier: "homeToBreathing", sender: nil)
//            navigationController2?.present(BreathingViewController(), animated: true, completion: {
//
//            })
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "breathing") as UIViewController
            navigationController2?.present(initialViewController, animated: true, completion: {
                
            })
            print("ngebalikin halaman breath")
            restorationHandler([workoutVC2])
            
            return true
        }else{
            return false
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

