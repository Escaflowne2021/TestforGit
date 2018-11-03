//
//  Component_Compteur.swift
//  TestforGit
//
//  Created by Cormier on 20/10/2018.
//  Copyright © 2018 Cormier. All rights reserved.
//

import UIKit



extension CGFloat {
    var degreesToRadians: CGFloat {return self * .pi / 180}
}

@IBDesignable
class Component_Compteur: UIView {
    
   
    @IBOutlet var ComponentView: UIView!
    @IBOutlet weak var L_Pourcentage: UILabel!
    @IBOutlet weak var compteur: compteur!
    
    
    var EndAngle: Float? = 90
    //var EndAnglePrecedent: Float? = 90
    var min: Float? = 0
    var max: Float? = 10
    var currentValue: Float?
    var currentPourcentage: Int?
    
    //weak var DelaguateDataLive: DataLive?
    static  var delagates = MulticastDelegate<DataLive>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    func setBorne(borneMin min: Float, borneMax max: Float){
        self.min = min
        self.max = max
    }
    
    func setCurrentValue(valeurActuelle valeurBrut: Float){
        //EndAnglePrecedent = EndAngle
        
        EndAngle = (360 * valeurBrut - min!)/max!
        currentPourcentage = Int((EndAngle! * 100)/360)
        self.L_Pourcentage.text = "\(currentPourcentage ?? -1) %"
        //DelaguateDataLive?.pourcentagePoidsLive(pourcentage: currentPourcentage ?? -1)
        Component_Compteur.delagates.invoke(invocation: { $0.pourcentagePoidsLive(pourcentage: currentPourcentage ?? -1) })
        
        self.compteur.setEndAngle(angle: Int(EndAngle ?? 40))
        //self.setNeedsDisplay()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("Component_Compteur", owner: self, options: nil)
        addSubview(ComponentView)
        //self.setNeedsDisplay()
        //ComponentView.
    }
    
    
}
