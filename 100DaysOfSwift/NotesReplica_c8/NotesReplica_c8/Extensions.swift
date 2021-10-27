//
//  Extensiosn.swift
//  NotesReplica_c8
//
//  Created by Elisey Ozerov on 27/10/2021.
//

import UIKit

extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}
