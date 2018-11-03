//
//  Light.swift
//  TestforGit
//
//  Created by Cormier on 20/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//

import UIKit

class Light: UIView {
    
    var EtatColor: UIColor?
    var EtatBool = false;
    
    override func draw(_ rect: CGRect) {
        EtatColor?.setFill()
        let path = UIBezierPath(ovalIn: rect)
        path.fill()
        
    }
    
    func PingLight(){
        EtatBool = !EtatBool
        self.Etat_Variable(ValeurBoolean: EtatBool)
    }
    
    func Etat_Variable(ValeurBoolean etat: Bool){
        EtatBool = etat
        if(etat){
            EtatColor = UIColor.green
        } else {
            EtatColor = UIColor.red
        }
        self.setNeedsDisplay()    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
