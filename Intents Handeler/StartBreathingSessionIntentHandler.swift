//
//  StartBreathingSessionIntentHandler.swift
//  Intents Handeler
//
//  Created by Yosua Hoo on 14/11/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import Foundation

final class StartBreathingSessionIntentHandler : NSObject, StartBreathingSessionIntentHandling{
    
    func handle(intent: StartBreathingSessionIntent, completion: @escaping (StartBreathingSessionIntentResponse) -> Void) {
        var inhale : Int?
        var exhale : Int?
        
        if let unwrappedInhale = intent.inhale{
            inhale = Int(unwrappedInhale)
        }else{
            inhale = UserDefaults.standard.value(forKey: "InhaleDuration")
        }
    }
    
    //Start Session
    
    //    func confirm(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
    //        <#code#>
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
