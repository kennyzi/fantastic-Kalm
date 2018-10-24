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
    
    var sessions : [Session] = []
    
    func createNewSession (session : Session) {
        let sessionRecord = CKRecord(recordType: "Session")
        
        sessionRecord["startDate"] = session.startDate
        sessionRecord["endDate"] = session.endDate
        
        saveRecordtoPublicDatabase(record: sessionRecord)
    }
    
    func saveRecordtoPublicDatabase (record : CKRecord) {
        let container = CKContainer.default()
        let database = container.publicCloudDatabase
        
        database.save(record) { (record, error) in
            if let errorUnwrapped = error{
                print("Error Save : \(errorUnwrapped.localizedDescription)")
            }
        }
    }
    
    func fetchStoryRecord () -> [Session]{
        let container = CKContainer.default()
        let database = container.publicCloudDatabase
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Session", predicate: predicate)
        
        var result : [Session] = []
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let errorUnwrapped = error{
                print("Error Fetch : \(errorUnwrapped)")
            }
            if let recordsUnwrapped = records{
                DispatchQueue.global().sync {
                    recordsUnwrapped.forEach({ (record) in
                        let session = self.decodeRecordtoSession(record: record)
                        guard let sessionUnwrapped = session else {return}
                        result.append(sessionUnwrapped)
                    })
                }
            }
            self.sessions = result
            print(self.sessions)
        }
        return result
    }
    
    func decodeRecordtoSession(record : CKRecord) -> Session?{
        let startDate = record["startDate"] as? Date
        let endDate = record["endDate"] as? Date
        
        guard let startDateUnwrapped = startDate else{return nil}
        guard let endDateUnwrapped = endDate else{return nil}
        
        let session = Session(startDate: startDateUnwrapped, endDate: endDateUnwrapped)
        return session
    }
}
