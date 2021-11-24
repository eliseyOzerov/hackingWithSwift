import UIKit

let name = "Taylor"

for letter in name {
    print("Give me a \(letter)!")
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[3]
