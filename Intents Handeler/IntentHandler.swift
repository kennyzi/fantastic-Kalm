//
//  IntentHandler.swift
//  Intents Handeler
//
//  Created by Kennyzi Yusuf on 13/11/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, INStartWorkoutIntentHandling, INEndWorkoutIntentHandling{
    func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print("start Workout Intent: ", intent)
        print("intent handeler")
        let userActivity: NSUserActivity? = nil
        guard let SpokenPhrase = intent.workoutName?.spokenPhrase else {
            completion(INStartWorkoutIntentResponse(code: .failureNoMatchingWorkout, userActivity: userActivity))
            return
        }
        print(SpokenPhrase)
        completion(INStartWorkoutIntentResponse(code: .handleInApp, userActivity: userActivity))
    }
    
    func resolveWorkoutName(for intent: INEndWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        resolveWorkout
    }
    func handle(intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
        
    }
}


