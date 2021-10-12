//
//  Person.swift
//  NamesToFaces_p10
//
//  Created by Elisey Ozerov on 12/10/2021.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
