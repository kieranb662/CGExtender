//
//  Clamping.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import Foundation


// MARK: Clamping

extension FloatingPoint {
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}

extension BinaryInteger {
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return max(min(self, range.upperBound), range.lowerBound)
    }
}
