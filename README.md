# CGExtender 

Useful extensions and functions used with coregraphics types like CGFloat, CGPoint, and CGSize 

## Collision Functions 

Checkout the [collisions example project](https://github.com/kieranb662/CollisionDetectionExamples) for how to make use of the functions in SwiftUI

* **Point/Line**
* **Point/Circle**
* **Point/Rectangle**
* **Point/Polygon**
* **Line/Line**
* **Line/Rectangle**
* **Line/Circle**
* **Line/Polygon**
* **Circle/Circle**
* **Circle/Rectangle**
* **Circle/Polygon**
* **Rectangle/Rectangle**
* **Rectangle/Polygon**
* **Polygon/Polygon**


## CGPoint 
- VectorArithmetic Conformance
- Random Value in range

## CGSize
- VectorArithmetic Conformance
- Random Value in range


## Clamping Functions

Clamps within range of two given values 

## Geometry Functions 

* `atanP` - function returns only positive values between [0, 2π] 
* `calculateDirection` -Calculates the direction between two points relative to the vector pointing in the trailing direction
* `project` - Projects the point `p` onto the line segment defined by the points `L1` and `L2`
* `calculateParameter` - Projects the point `p` onto the vector defined by the points `L1` and `L2`,  uses the parametric form of the line segment from `L1` to `L2` to constrain the projected point to be on the line segment
* `distance` - gets the distance between two points 



