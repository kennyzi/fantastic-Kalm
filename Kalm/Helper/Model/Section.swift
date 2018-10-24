//
//  Section.swift
//  Kalm
//
//  Created by Klaudius Ivan on 26/06/18.
//  Copyright © 2018 Marvin Randy. All rights reserved.
//

import Foundation

class Section{
    var question: String!
    var detail: [String]!
    var expanded: Bool!
    
    init(question: String, detail: [String], expanded: Bool) {
        self.question = question
        self.detail = detail
        self.expanded = expanded
    }
}
