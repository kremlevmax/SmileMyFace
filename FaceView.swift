//
//  FaceView.swift
//  FaceView
//
//  Created by Сервис on 20/03/2017.
//  Copyright © 2017 Kremlev. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.9
    private var _smileRation: CGFloat = 0
    var smileRation: CGFloat {
        set (newSmileRation) {
           _smileRation = max(-1, min(newSmileRation, 1))
            setNeedsDisplay()
        } get {
            return _smileRation
        }
    }
    
    private var faceRadius: CGFloat {
        return (min(bounds.width, bounds.height) / 2) * scale
    }
    
    private var faceCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    override func draw(_ rect: CGRect) {
        drawFace().stroke()
        drawEyes(.left).stroke()
        drawEyes(.right).stroke()
        drawSmile(smileRatio: smileRation).stroke()

    }
    
    
    func drawFace() -> UIBezierPath {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        facePath.lineWidth = 5
        return facePath
    }
    
    
    func drawEyes(_ eye: Eye) -> UIBezierPath {
        
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffcet = faceRadius/relationConstants.faceRadiusToEyeOffset
            var eyeCenter = faceCenter
            eyeCenter.y -= eyeOffcet
            eyeCenter.x += ((eye == .left) ? -1 : 1)*eyeOffcet
            return eyeCenter
        }
        
        let eyeRadius = faceRadius/relationConstants.faceRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        let eyePath = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        eyePath.lineWidth = 5
        UIColor.gray.set()
        eyePath.fill()
        return eyePath
    }
    
    func drawSmile(smileRatio : CGFloat) -> UIBezierPath {

        let smileOffset = faceRadius/relationConstants.faceRadiusToMouthOffset
        let smileWidth = faceRadius/relationConstants.faceRadiusToSmileWidth
        let smileHeight = faceRadius/relationConstants.faceRadiusToSmileHeight
        
        let startPoint = CGPoint(x: faceCenter.x - smileWidth / 2, y: faceCenter.y + smileOffset)
        
        let endPoint = CGPoint(x: faceCenter.x + smileWidth / 2, y: faceCenter.y + smileOffset)
        
        
        let cp1 = CGPoint(x: faceCenter.x - smileWidth / 3, y: faceCenter.y + smileOffset + smileHeight * smileRatio)
        let cp2 = CGPoint(x: faceCenter.x + smileWidth / 3, y: faceCenter.y + smileOffset + smileHeight * smileRatio)
        
        
        
        let smilePath = UIBezierPath()
        
        smilePath.lineWidth = 5
        smilePath.move(to: startPoint)
        smilePath.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return smilePath
    }
    
    enum Eye {
        case right
        case left
    }
    
    struct relationConstants {
        static let faceRadiusToEyeOffset: CGFloat = 3
        static let faceRadiusToEyeRadius: CGFloat = 10
        static let faceRadiusToSmileWidth: CGFloat = 1
        static let faceRadiusToSmileHeight: CGFloat = 3
        static let faceRadiusToMouthOffset: CGFloat = 3
        
        
        
    }
    
}
