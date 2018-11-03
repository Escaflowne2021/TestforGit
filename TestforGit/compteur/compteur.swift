//
//  compteur.swift
//  TestforGit
//
//  Created by Cormier on 21/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//

import UIKit

@IBDesignable
class compteur: UIView {

     var EndAngle: Int? = 90
    
    override func draw(_ rect: CGRect) {
        
        let ViewCenter = CGPoint(x: rect.width/2, y: rect.height/2)
        let radius = rect.width*0.4
        let startAngle: Float = 0 + 90
        let endAngle = (EndAngle ?? Int(startAngle)) + 90
        
        UIColor.blue.setStroke()
        let path = UIBezierPath()
        //path.move(to: ViewCenter)
        
        
        
        path.addArc(withCenter: ViewCenter, radius: radius, startAngle: CGFloat(startAngle).degreesToRadians, endAngle: CGFloat(endAngle).degreesToRadians, clockwise: true)
        path.lineWidth = 10
        path.stroke()
        //path.close()
        //path.fill()
        
        
    }
    
    func setEndAngle(angle endAngle : Int){
        self.EndAngle = endAngle
        self.setNeedsDisplay()
    }

}
