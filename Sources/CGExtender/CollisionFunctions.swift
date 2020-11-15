//
//  CollisionFunctions.swift
//  MyExamples
//
//  Created by Kieran Brown on 4/2/20.
//  Copyright © 2020 BrownandSons. All rights reserved.
//

import CoreGraphics

// MARK: - RECTANGLE/RECTANGLE

public func rectRect(_ r1x: CGFloat, _ r1y: CGFloat, _ r1w: CGFloat, _ r1h: CGFloat, _ r2x: CGFloat, _ r2y: CGFloat, _ r2w: CGFloat, _ r2h: CGFloat) -> Bool {
    // are the sides of one rectangle touching the other?
    if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
        r1x <= r2x + r2w &&    // r1 left edge past r2 right
        r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
        r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true
    }
    return false
}

// MARK: - CIRCLE/RECTANGLE

public func circleRect(_ cx: CGFloat, _ cy: CGFloat, _ radius: CGFloat, _ rx: CGFloat, _ ry: CGFloat, _ rw: CGFloat, _ rh: CGFloat) -> Bool {
    // temporary variables to set edges for testing
    var testX = cx;
    var testY = cy;
    
    // which edge is closest?
    if (cx < rx)  {       testX = rx; }     // test left edge
    else if (cx > rx+rw) { testX = rx+rw;  } // right edge
    if (cy < ry)        { testY = ry;}      // top edge
    else if (cy > ry+rh) {testY = ry+rh;}   // bottom edge
    
    // get distance from closest edges
    let distX = cx-testX;
    let distY = cy-testY;
    let distance = sqrt( (distX*distX) + (distY*distY) );
    
    // if the distance is less than the radius, collision!
    if (distance <= radius) {
        return true;
    }
    return false;
}

// MARK: - POINT/RECTANGLE

public func pointRect(_ px: CGFloat, _ py: CGFloat, _ rx: CGFloat, _ ry: CGFloat, _ rw: CGFloat, _ rh: CGFloat) -> Bool {
    // is the point inside the rectangle's bounds?
    if (px >= rx &&        // right of the left edge AND
        px <= rx + rw &&   // left of the right edge AND
        py >= ry &&        // below the top AND
        py <= ry + rh) {   // above the bottom
        return true
    }
    return false
}

// MARK: - POINT/CIRCLE

public func pointCircle(_ px: CGFloat, _ py: CGFloat, _ cx: CGFloat, _ cy: CGFloat, _ r: CGFloat) -> Bool  {
    // get distance between the point and circle's center
    // using the Pythagorean Theorem
    let distX = px - cx;
    let distY = py - cy;
    let distance = sqrt( (distX*distX) + (distY*distY) );
    // if the distance is less than the circle's
    // radius the point is inside!
    if (distance <= r) {
        return true
    }
    return false
}

// MARK: - CIRCLE/CIRCLE
public func circleCircle(_ c1x: CGFloat, _ c1y: CGFloat, _ c1r: CGFloat, _ c2x: CGFloat, _ c2y: CGFloat, _ c2r: CGFloat) -> Bool {
    // get distance between the circle's centers
    // use the Pythagorean Theorem to compute the distance
    let distX = c1x - c2x;
    let distY = c1y - c2y;
    let distance = sqrt( (distX*distX) + (distY*distY) );
    // if the distance is less than the sum of the circle's
    // radii, the circles are touching!
    if (distance <= c1r+c2r) {
        return true
    }
    return false
}

// MARK: - LINE/POINT

public func linePoint( _ x1: CGFloat, _  y1: CGFloat, _  x2: CGFloat, _  y2: CGFloat, _  px: CGFloat, _  py: CGFloat) -> Bool  {
    // get distance from the point to the two ends of the line
    let d1: CGFloat = distance(CGPoint(x: px, y: py), CGPoint(x: x1, y: y1))
    let d2: CGFloat = distance(CGPoint(x: px, y: py), CGPoint(x: x2, y: y2))
    
    // get the length of the line
    let lineLen: CGFloat = distance(CGPoint(x: x1, y: y1), CGPoint(x: x2, y: y2))
    
    // since floats are so minutely accurate, add
    // a little buffer zone that will give collision
    let buffer: CGFloat = 0.1;    // higher # = less accurate
    
    // if the two distances are equal to the line's
    // length, the point is on the line!
    // note we use the buffer here to give a range,
    // rather than one #
    if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
        return true
    }
    return false
}

// MARK: - LINE/CIRCLE

public func lineCircle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cx: CGFloat, _ cy: CGFloat, _ r: CGFloat) -> Bool  {
    // is either end INSIDE the circle?
    // if so, return true immediately
    let inside1 = pointCircle(x1,y1, cx,cy,r)
    let inside2 = pointCircle(x2,y2, cx,cy,r)
    if (inside1 || inside2) {return true}
    // get length of the line
    var distX = x1 - x2
    var distY = y1 - y2
    let len = sqrt( (distX*distX) + (distY*distY) )
    // get dot product of the line and circle
    let dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len,2)
    // find the closest point on the line
    let closestX = x1 + (dot * (x2-x1));
    let closestY = y1 + (dot * (y2-y1));
    // is this point actually on the line segment?
    // if so keep going, but if not, return false
    let onSegment = linePoint(x1,y1,x2,y2, closestX,closestY)
    if (!onSegment) { return false }
    // get distance to closest point
    distX = closestX - cx;
    distY = closestY - cy;
    let distance = sqrt( (distX*distX) + (distY*distY) );
    
    if (distance <= r) {
        return true;
    }
    return false;
}

// MARK: - Line/Line

public func lineLine(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) -> Bool {
    // calculate the distance to intersection point
    let uA: CGFloat = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    let uB: CGFloat = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    
    return (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1)
}

// MARK: - LINE/RECTANGLE

public func lineRect(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ rx: CGFloat, _ ry: CGFloat, _ rw: CGFloat, _ rh: CGFloat) -> Bool  {
    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    let left =   lineLine(x1,y1,x2,y2, rx,ry,rx, ry+rh);
    let right =  lineLine(x1,y1,x2,y2, rx+rw,ry, rx+rw,ry+rh);
    let top =    lineLine(x1,y1,x2,y2, rx,ry, rx+rw,ry);
    let bottom = lineLine(x1,y1,x2,y2, rx,ry+rh, rx+rw,ry+rh);
    // if ANY of the above are true, the line
    // has hit the rectangle
    if (left || right || top || bottom) {
        return true
    }
    return false
}

// MARK: - POLYGON/POINT

public func polygonPoint(_ vertices: [CGPoint], _ px: CGFloat, _ py: CGFloat) -> Bool  {
    var collision = false
    // go through each of the vertices, plus
    // the next vertex in the list
    var next = 0
    for current in 0..<vertices.count {
        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1;
        if (next == vertices.count) { next = 0 }
        // get the vectors at our current position
        // this makes our if statement a little cleaner
        let vc = vertices[current];    // c for "current"
        let vn = vertices[next];       // n for "next"
        // compare position, flip 'collision' variable
        // back and forth
        if (((vc.y >= py && vn.y < py) || (vc.y < py && vn.y >= py)) &&
            (px < (vn.x-vc.x)*(py-vc.y) / (vn.y-vc.y)+vc.x)) {
            collision = !collision
        }
    }
    return collision
}

// MARK: - POLYGON/CIRCLE

public func polyCircle(vertices: [CGPoint], _ cx: CGFloat, _ cy: CGFloat, _ r: CGFloat) -> Bool {
    // go through each of the vertices, plus
    // the next vertex in the list
    var next = 0
    for current in  0..<vertices.count {
        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1
        if (next == vertices.count) { next = 0 }
        // get the PVectors at our current position
        // this makes our if statement a little cleaner
        let vc = vertices[current]    // c for "current"
        let vn = vertices[next]    // n for "next"
        // check for collision between the circle and
        // a line formed between the two vertices
        let collision = lineCircle(vc.x,vc.y, vn.x,vn.y, cx,cy,r);
        if (collision) { return true }
    }
    
    // the above algorithm only checks if the circle
    // is touching the edges of the polygon – in most
    // cases this is enough, but you can un-comment the
    // following code to also test if the center of the
    // circle is inside the polygon
    
    // boolean centerInside = polygonPoint(vertices, cx,cy);
    // if (centerInside) return true;
    
    // otherwise, after all that, return false
    return false
}

// MARK: - POLYGON/RECTANGLE

public func polyRect(_ vertices: [CGPoint], _ rx: CGFloat, _ ry: CGFloat, _ rw: CGFloat, _ rh: CGFloat) -> Bool  {
    // go through each of the vertices, plus the next
    // vertex in the list
    var next = 0
    for current in 0..<vertices.count {
        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1
        if (next == vertices.count) { next = 0 }
        // get the vectors at our current position
        // this makes our if statement a little cleaner
        let vc = vertices[current];    // c for "current"
        let vn = vertices[next];       // n for "next"
        // check against all four sides of the rectangle
        let collision = lineRect(vc.x,vc.y,vn.x,vn.y, rx,ry,rw,rh);
        if (collision) {return true}
        // optional: test if the rectangle is INSIDE the polygon
        // note that this iterates all sides of the polygon
        // again, so only use this if you need to
        let inside = polygonPoint(vertices, rx,ry);
        if (inside){ return true}
    }
    return false;
}

// MARK: - POLYGON/LINE

public func polyLine(_ vertices: [CGPoint], _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) -> Bool  {
    // go through each of the vertices, plus the next
    // vertex in the list
    var next = 0
    for current in 0..<vertices.count {
        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1
        if (next == vertices.count) {next = 0}
        // get the vectors at our current position
        // extract X/Y coordinates from each
        let x3 = vertices[current].x;
        let y3 = vertices[current].y;
        let x4 = vertices[next].x;
        let y4 = vertices[next].y;
        // do a Line/Line comparison
        // if true, return 'true' immediately and
        // stop testing (faster)
        let hit = lineLine(x1, y1, x2, y2, x3, y3, x4, y4);
        if (hit) {
            return true
        }
    }
    // never got a hit
    return false
}

// MARK: - POLYGON/POLYGON

public func polyPoly(_ p1: [CGPoint], _ p2: [CGPoint]) -> Bool  {
    // go through each of the vertices, plus the next
    // vertex in the list
    var next = 0;
    for current in 0..<p1.count  {
        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1;
        if (next == p1.count) {next = 0 }
        // get the vectors at our current position
        // this makes our if statement a little cleaner
        let vc = p1[current];    // c for "current"
        let vn = p1[next];       // n for "next"
        // now we can use these two points (a line) to compare
        // to the other polygon's vertices using polyLine()
        var collision = polyLine(p2, vc.x,vc.y,vn.x,vn.y);
        if (collision) { return true }
        // optional: check if the 2nd polygon is INSIDE the first
        collision = polygonPoint(p1, p2[0].x, p2[0].y);
        if (collision) { return true }
    }
    return false;
}

// MARK: - Triangle/Point

public func triPoint(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ px: CGFloat, _ py: CGFloat) -> Bool  {
    // get the area of the triangle
    let areaOrig = abs( (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1) );
    // get the area of 3 triangles made between the point
    // and the corners of the triangle
    let area1 =    abs( (x1-px)*(y2-py) - (x2-px)*(y1-py) );
    let area2 =    abs( (x2-px)*(y3-py) - (x3-px)*(y2-py) );
    let area3 =    abs( (x3-px)*(y1-py) - (x1-px)*(y3-py) );
    // if the sum of the three areas equals the original,
    // we're inside the triangle!
    if (area1 + area2 + area3 == areaOrig) {
        return true
    }
    return false
}


// MARK: - Points Of Intersection

public func lineLineIntersection(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) -> (Bool, CGPoint) {
    // calculate the direction of the lines
    let uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    let uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
        // optionally, draw a circle where the lines meet
        let intersectionX = x1 + (uA * (x2-x1));
        let intersectionY = y1 + (uA * (y2-y1));
        
        return (true , CGPoint(x: intersectionX, y: intersectionY))
    }
    return (false, .zero)
}


public func lineRectIntersection(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ rx: CGFloat, _ ry: CGFloat, _ rw: CGFloat, _ rh: CGFloat) -> [CGPoint] {
    var points = [CGPoint]()
    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    let left =   lineLineIntersection(x1,y1,x2,y2, rx,ry,rx, ry+rh);
    let right =  lineLineIntersection(x1,y1,x2,y2, rx+rw,ry, rx+rw,ry+rh);
    let top =    lineLineIntersection(x1,y1,x2,y2, rx,ry, rx+rw,ry);
    let bottom = lineLineIntersection(x1,y1,x2,y2, rx,ry+rh, rx+rw,ry+rh);
    
    if left.0 {points.append(left.1)}
    if right.0 {points.append(right.1)}
    if top.0 {points.append(top.1)}
    if bottom.0 {points.append(bottom.1)}
    
    return points
}
