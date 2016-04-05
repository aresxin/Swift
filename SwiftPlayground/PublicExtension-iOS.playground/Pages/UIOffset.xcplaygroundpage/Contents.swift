//: [Table of Contents](Table%20of%20Contents)

import UIKit

extension UIOffset: ArrayLiteralConvertible {
    public init(arrayLiteral elements: CGFloat...) {
        guard elements.count == 2 else { fatalError("2 CGFloats required!") }
        
        horizontal = elements[0]
        vertical = elements[1]
    }
}
