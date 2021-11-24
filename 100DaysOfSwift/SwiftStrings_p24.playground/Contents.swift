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

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5) {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

extension Int {
    func times(_ closure: () -> Void) {
        for _ in 0..<self {
            closure()
        }
    }
}

5.times {
    print("Hello!")
}

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if self.filter({$0 == item}).count > 1 {
            self.remove(at: self.firstIndex(of: item)!)
        }
    }
}

var array = [1,2,3,4,5,1]

array.remove(item: 1)

print(array)
