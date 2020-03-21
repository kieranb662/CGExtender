//
//  Clamping.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import Foundation


// MARK: Clamping
extension FloatingPoint {
func clamped(to range: ClosedRange<Self>) -> Self {
return max(min(self, range.upperBound), range.lowerBound)
    }
}
extension BinaryInteger {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}
