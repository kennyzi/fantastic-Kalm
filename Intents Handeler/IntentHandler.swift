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

class IntentHandler: INExtension{
//    func handle(intent: StartBreathingSessionIntent, completion: @escaping (StartBreathingSessionIntentResponse) -> Void) {
//        print(intent)
//    }
    
    override func handler(for intent: INIntent) -> Any? {
        guard intent is StartBreathingSessionIntent else{
            fatalError("Unhandled intent type : \(intent)")
        }
        
        return StartBreathingSessionIntentHandler()
    }
    
}


