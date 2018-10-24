//
//  CloudKitHelper.swift
//  Kalm
//
//  Created by Yosua Hoo on 24/10/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitHelper {
    func createNewSession (session : Session) {
        let sessionRecord = CKRecord(recordType: "Session")
        
        sessionRecord["startDate"] = session.startDate
        sessionRecord["endDate"] = session.endDate
    }
}
