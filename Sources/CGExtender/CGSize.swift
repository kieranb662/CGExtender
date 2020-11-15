//
//  CGSize.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import SwiftUI

// MARK: - CGSize VectorArithmetic Conformance

extension CGSize: VectorArithmetic {
    public static func -= (lhs: inout CGSize, rhs: CGSize) {
        lhs.width -= rhs.width
        lhs.height -= rhs.height
    }
    
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width+rhs.width,
               height: lhs.height+rhs.height)
    }
    
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width-rhs.width,
               height: lhs.height-rhs.height)
    }
    
    public mutating func scale(by rhs: Double) {
        width *= CGFloat(rhs)
        height *= CGFloat(rhs)
    }
    
    public var magnitudeSquared: Double {
        Double(width*width+height*height)
    }
    
    public static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }
    
}


// MARK: - CGSize Convienience

extension CGSize {
    public func toPoint() -> CGPoint {
        CGPoint(x: width, y: height)
    }
    
    public static func random(from: Range<CGFloat>) -> CGSize {
        CGSize(width: .random(in: from),
               height: .random(in: from))
    }
    
    public static func random(from: ClosedRange<CGFloat>) -> CGSize {
        CGSize(width: .random(in: from),
               height: .random(in: from))
    }
    
    public static func random(from: Range<Double>) -> CGSize {
        CGSize(width: .random(in: from),
               height: .random(in: from))
    }
    
    public static func random(from: ClosedRange<Double>) -> CGSize {
        CGSize(width: .random(in: from),
               height: .random(in: from))
    }
}
