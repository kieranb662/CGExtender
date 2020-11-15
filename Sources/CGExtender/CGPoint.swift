//
//  CGPoint.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import SwiftUI

// MARK: - CGPoint VectorArithmetic Conformance

extension CGPoint: VectorArithmetic {
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }
    
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
    
    public mutating func scale(by rhs: Double) {
        x *= CGFloat(rhs)
        y *= CGFloat(rhs)
    }
    
    public var magnitudeSquared: Double {
        Double(x*x+y*y)
    }
    
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}


// MARK: - CGPoint Convienience Extension

extension CGPoint {
    public func toSize() -> CGSize {
        CGSize(width: x, height: y)
    }
    
    public static func random(from: Range<CGFloat>) -> CGPoint {
        CGPoint(x: .random(in: from),
                y: .random(in: from))
    }
    
    public static func random(from: ClosedRange<CGFloat>) -> CGPoint {
        CGPoint(x: .random(in: from),
                y: .random(in: from))
    }
    
    public static func random(from: Range<Double>) -> CGPoint {
        CGPoint(x: .random(in: from),
                y: .random(in: from))
    }
    
    public static func random(from: ClosedRange<Double>) -> CGPoint {
        CGPoint(x: .random(in: from),
                y: .random(in: from))
    }
}
