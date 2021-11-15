//
//  Note.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 12/11/2021.
//

import Foundation

struct Note: Codable {
    var text: String!
    var lastChanged: Date!
}
