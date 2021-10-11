//
//  Petition.swift
//  WhiteHousePetitions_p7
//
//  Created by Elisey Ozerov on 08/10/2021.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
