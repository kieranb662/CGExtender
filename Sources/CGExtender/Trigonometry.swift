//
//  File.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import CoreGraphics


/// Returns only positive values between [0, 360]
func atanP(x: Double, y: Double) -> Double {
    if x > 0 && y>=0 {
        return atan(y/x)
    } else if x>0 && y<0 {
        return 2*Double.pi + atan(y/x)
    } else if x < 0 && y >= 0{
        return .pi + atan(y/x)
    } else if x < 0 && y < 0 {
        return .pi + atan(y/x)
    } else if x==0 && y>=0 {
        return .pi/2
    } else if x == 0 && y < 0 {
        return 3/2*Double.pi
    } else {
        return 0
    }
    
}

/// Returns only positive values between [0, 360]
func atanP(x: CGFloat, y: CGFloat) -> CGFloat {
    if x > 0 && y>=0 {
        return atan(y/x)
    } else if x>0 && y<0 {
        return 2*CGFloat.pi + atan(y/x)
    } else if x < 0 && y >= 0{
        return .pi + atan(y/x)
    } else if x < 0 && y < 0 {
        return .pi + atan(y/x)
    } else if x==0 && y>=0 {
        return .pi/2
    } else if x == 0 && y < 0 {
        return 3/2*CGFloat.pi
    } else {
        return 0
    }
    
}
