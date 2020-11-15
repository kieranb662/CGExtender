//
//  File.swift
//  
//
//  Created by Kieran Brown on 3/21/20.
//

import CoreGraphics

/// Returns only positive values between [0, 2π]
public func atanP(x: Double, y: Double) -> Double {
    if x>0 && y>=0 {
        return atan(y/x)
        
    } else if x>0 && y<0 {
        return 2*Double.pi + atan(y/x)
        
    } else if x<0 && y>=0 {
        return .pi + atan(y/x)
        
    } else if x<0 && y<0 {
        return .pi + atan(y/x)
        
    } else if x==0 && y>=0 {
        return .pi/2
        
    } else if x==0 && y<0 {
        return 3/2*Double.pi
        
    } else {
        return 0
    }
    
}

/// Returns only positive values between [0, 2π]
public func atanP(x: CGFloat, y: CGFloat) -> CGFloat {
    CGFloat(atanP(x: Double(x), y: Double(y)))
}

/// Calculated the direction between two points relative to the vector pointing in the trailing direction
public func calculateDirection(_ pt1: CGPoint, _ pt2: CGPoint) -> Double {
    let a = pt2.x - pt1.x
    let b = pt2.y - pt1.y
    
    return Double(atanP(x: a, y: b)/(2 * .pi))
}

/// Projects the point `p` onto the line segment defined by the points `L1` and `L2`
public func project(_ L1: CGPoint, _ L2: CGPoint, _ p: CGPoint) -> CGPoint {
    let onTo = L1-L2
    let vector = L1 - p
    let top = onTo.x*vector.x + onTo.y*vector.y
    let scalar = top/CGFloat(onTo.magnitudeSquared)
    return CGPoint(x: scalar*onTo.x, y: scalar*onTo.y)
}

/// Projects the first vector onto the second vector
public func project(_ vector: CGSize, _ onto: CGSize) -> CGSize {
    let top = onto.width*vector.width + onto.height*vector.height
    let scalar = top/CGFloat(onto.magnitudeSquared)
    return CGSize(width: scalar*onto.width, height: scalar*onto.height)
}

/// Projects the point `p` onto the vector defined by the points `L1` and `L2`,  uses the parametric
///  form of the line segment from `L1` to `L2` to constrain the projected point to be on the line segment
public func calculateParameter(_ L1: CGPoint, _ L2: CGPoint, _ p: CGPoint) -> CGFloat {
    let temp = project(L1, L2, p)
    
    if L1.x == L2.x && L1.y != L2.y {
        return max(min((temp.y)/(L1.y - L2.y), 1), 0)
    } else if L1.x != L2.x  {
        return max(min((temp.x)/(L1.x - L2.x), 1), 0)
    } else {
        return  0
    }
}

public func distance(_ p1: CGPoint, _ p2: CGPoint) -> Double {
    sqrt((p1-p2).magnitudeSquared)
}

public func distance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    CGFloat(sqrt((p1-p2).magnitudeSquared))
}
