//
//  StartBreathingSessionIntentHandler.swift
//  Intents Handeler
//
//  Created by Yosua Hoo on 14/11/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import Foundation

final class StartBreathingSessionIntentHandler : NSObject, StartBreathingSessionIntentHandling{
    
    
    func confirm(intent: StartBreathingSessionIntent, completion: @escaping (StartBreathingSessionIntentResponse) -> Void) {
        completion(StartBreathingSessionIntentResponse(code: .continueInApp, userActivity: nil))
        print(intent)
    }
    
    func handle(intent: StartBreathingSessionIntent, completion: @escaping (StartBreathingSessionIntentResponse) -> Void) {
        var inhale : Int?
        var exhale : Int?
        var isSuccess = true
        
        if let unwrappedInhale = intent.inhale{
            inhale = Int(truncating: unwrappedInhale)
            UserDefaults.standard.setValue(inhale, forKey: "inhaleDuration")
        }else{
            isSuccess = false
            if UserDefaults.standard.value(forKey: "inhaleDuration") != nil{
                if let savedInhaleDuration = UserDefaults.standard.value(forKey: "inhaleDuration") as? Int{
                    inhale = savedInhaleDuration
                }
            }
        }
        
        if let unwrappedExhale = intent.exhale{
            exhale = Int(truncating: unwrappedExhale)
            UserDefaults.standard.setValue(exhale, forKey: "exhaleDuration")
        }else{
            isSuccess = false
            if UserDefaults.standard.value(forKey: "exhaleDuration") != nil{
                if let savedExhaleDuration = UserDefaults.standard.value(forKey: "exhaleDuration") as? Int{
                    exhale = savedExhaleDuration
                }
            }
        }
        
        intent.name = "Session"
        
        if isSuccess == true{
            completion(StartBreathingSessionIntentResponse(code: .successWithInhaleExhale, userActivity: nil))
        }else{
            completion(StartBreathingSessionIntentResponse(code: .success, userActivity: nil))
        }
    }
    
    //Start Session
    
    //    func confirm(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
    //
    //    }
    
//    func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
//        print("start Workout Intent: ", intent)
//        print("intent handeler")
//        let userActivity: NSUserActivity? = nil
//        guard let SpokenPhrase = intent.workoutName?.spokenPhrase else {
//            completion(INStartWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: userActivity))
//            return
//        }
//        print(SpokenPhrase)
//        completion(INStartWorkoutIntentResponse(code: .handleInApp, userActivity: userActivity))
//    }
//
//
//    //End Session
//    func handle(intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
//
//    }
}
